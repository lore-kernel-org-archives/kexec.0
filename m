Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZTsZo-0005AI-Nw
 for kexec@lists.infradead.org; Mon, 24 Aug 2015 14:18:21 +0000
Received: by wicja10 with SMTP id ja10so73519277wic.1
 for <kexec@lists.infradead.org>; Mon, 24 Aug 2015 07:17:59 -0700 (PDT)
Subject: Re: Dmesg not being dumped
References: <mailman.5.1440010802.20553.kexec@lists.infradead.org>
 <2097586247.19732970.1440016713516.JavaMail.zimbra@redhat.com>
 <55D57913.2070303@kyup.com>
 <1497907178.20184517.1440075877293.JavaMail.zimbra@redhat.com>
 <55D6DCD6.8050000@kyup.com>
 <435200626.24541654.1440421412725.JavaMail.zimbra@redhat.com>
From: Nikolay Borisov <kernel@kyup.com>
Message-ID: <55DB2795.6050108@kyup.com>
Date: Mon, 24 Aug 2015 17:17:57 +0300
MIME-Version: 1.0
In-Reply-To: <435200626.24541654.1440421412725.JavaMail.zimbra@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Anderson <anderson@redhat.com>
Cc: kexec@lists.infradead.org



On 08/24/2015 04:03 PM, Dave Anderson wrote:
> 
> 
> ----- Original Message -----
>>
>>
>> On 08/20/2015 04:04 PM, Dave Anderson wrote:
>>> The vmcoreinfo data strings were initially located in an ELF note in /proc/vmcore.
>>> When makedumpfile -c was run on /proc/vmcore, it copied those ELF notes into the
>>> compressed kdump header, and you have dumped them above.
>>>
>>> So it seems to be an issue with vmcore-dmesg.  If you change the core_collector
>>> variable to "cp" or "scp", it will copy /proc/vmcore unmodified to the target
>>> location.  Then you can run vmcore-dmesg on that file to debug it.
>>
>> This is very, very odd. Obtaining a raw vmcore with cp and then running
>> vmcore-dmesg does show the dmesg log. But at the same time, the
>> vmcore-dmesg.txt file is empty and its name is
>> vmcore-dmesg-incomplete.txt...
> 
> I'm not sure what you mean.  Similar to the saving of the vmcore file, the
> script directs the output of vmcore-dmesg into vmcore-dmesg-incomplete.txt.
> Then, only if vmcore-dmesg returns an exit status of 0, the script will 
> rename the file to vmcore-dmesg.txt.

vmcore-dmesg vmcore
<dmesg log is printed"
echo $?
0

so vmcore-dmesg succeeds but for some reason the dmesg is not being
redirrected to the txt file. Yes the vmcore-dmesg-incomplete.txt is
empty when the crash dump was invoked.

So to sum up my findings so far:

* When a crash dump is invoked the with the -c option of makedumpfile I
get an empty vmcore-dmesg-incomplete.txt. And the error string printed
on screen while taking the dump is: "struct log size not exported".
Looking at the code this can happen if the "printk_log" symbol cannot be
found. However, when I load the resulting vmcore image in crash and
invoke help -n I see that the correct symbol is there.

* When a raw coredump is taken (via cp as a collector) I still have an
empty vmcore-dmesg-incomplete.txt file, yet when I manually run
vmcore-dmesg on the resulting vmcore the dmesg is extracted and the
return code of the vmcore-dmesg script is 0 (success).

Having those facts in mind and what you said I do not see a logical
reason why dmesg is not being stored in the text file.

So either I'm missing something or the error message that is being
printed is very misleading, even though the code that involves is not
complicated it at all. Hm....

> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
