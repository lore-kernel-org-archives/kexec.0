From: Christophe Leroy <christophe.leroy@csgroup.eu>
Date: Fri, 11 Mar 2022 18:42:24 +0100
Subject: [PATCHv5 0/3] enable nr_cpus for powerpc
In-Reply-To: <CAFgQCTu3NRA1vi6auftHeXBWvPWgZRRURLHB6u7ih0TnkrzXrQ@mail.gmail.com>
References: <1521088912-31742-1-git-send-email-kernelfans@gmail.com>
 <CAFgQCTu3NRA1vi6auftHeXBWvPWgZRRURLHB6u7ih0TnkrzXrQ@mail.gmail.com>
Message-ID: <5b5840ab-e8ee-fa34-06e0-ca6269f2e211@csgroup.eu>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org



Le 23/03/2018 ? 06:28, Pingfan Liu a ?crit?:
> Maintainers, ping? Any comment?

This series doesn't apply anymore, and it has build failure report from 
the robot.

If it's still relevant, please rebase and fix.

Christophe

> 
> Thanks
> 
> On Thu, Mar 15, 2018 at 12:41 PM, Pingfan Liu <kernelfans@gmail.com> wrote:
>> This topic has a very long history. It comes from Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>> For v3: https://patchwork.ozlabs.org/patch/834860/
>> I hope we can acquire it for "kexec -p" soon.
>>
>> V4->V5:
>>    improve the [1/3] implementation based on Benjamin's suggestion.
>>
>> Mahesh Salgaonkar (1):
>>    ppc64 boot: Wait for boot cpu to show up if nr_cpus limit is about to
>>      hit.
>>
>> Pingfan Liu (2):
>>    powerpc, cpu: partially unbind the mapping between cpu logical id and
>>         its seq in dt
>>    powerpc, cpu: handling the special case when boot_cpuid greater than
>>      nr_cpus
>>
>>   arch/powerpc/include/asm/paca.h    |  3 +++
>>   arch/powerpc/include/asm/smp.h     |  2 ++
>>   arch/powerpc/kernel/paca.c         | 19 ++++++++++++++-----
>>   arch/powerpc/kernel/prom.c         | 27 ++++++++++++++++-----------
>>   arch/powerpc/kernel/setup-common.c | 35 ++++++++++++++++++++++++++++++++---
>>   5 files changed, 67 insertions(+), 19 deletions(-)
>>
>> --
>> 2.7.4
>>

