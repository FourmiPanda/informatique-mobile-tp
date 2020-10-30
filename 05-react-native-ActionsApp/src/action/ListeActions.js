import React from 'react'
import {View, Text, ScrollView} from 'react-native'
import UneAction from './UneAction'


const ListeActions = ({actions}) => {

    return (
        <View>
            {actions.map((prop) => {
                return (
                    <UneAction action={prop}/>
                );
            })}
        </View>
    )
}

export default ListeActions