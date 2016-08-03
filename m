Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bUla5-000253-Nk
 for kexec@lists.infradead.org; Wed, 03 Aug 2016 02:06:50 +0000
Message-ID: <57A15156.3060507@cn.fujitsu.com>
Date: Wed, 3 Aug 2016 10:05:10 +0800
From: =?UTF-8?B?Ilpob3UsIFdlbmppYW4v5ZGo5paH5YmRIg==?=
 <zhouwj-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/2] Documentation: kdump: add description of bringing
 up SMP dump-capture kernel
References: <1470185952-23477-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <1470185952-23477-2-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <20160803015818.GB2465@x1.redhat.com>
In-Reply-To: <20160803015818.GB2465@x1.redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, d.hatayama@jp.fujitsu.com, dyoung@redhat.com, linux-kernel@vger.kernel.org

On 08/03/2016 09:58 AM, Baoquan He wrote:
> On 08/03/16 at 08:59am, Zhou Wenjian wrote:
>> SMP dump-capture kernel is useful to improve the performance of kdump in
>> some cases. So add the description of bringing up SMP dump-capture kernel.
>>
>> Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
>> ---
>>   Documentation/kdump/kdump.txt | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
>> index 4aa194e..948b42d 100644
>> --- a/Documentation/kdump/kdump.txt
>> +++ b/Documentation/kdump/kdump.txt
>> @@ -396,6 +396,13 @@ Notes on loading the dump-capture kernel:
>>     Note, though maxcpus always works, we should replace it by nr_cpus to
>>     save memory if supported by the current ARCH, such as x86.
>>
>> +* We should bring up a SMP dump-capture kernel if we intend to use
>
> Well, here about SMP dump-capture kernel do you mean kdump kernel with
> multi-cpu? If I understand it correctly, it's still SMP kdump kernel
> though nr_cpus=1 is specified.
>

Actually, I haven't know the detail about it. I wrote the sentence almost
based on the original description:

* We generally don' have to bring up a SMP kernel just to capture the
   dump. Hence generally it is useful either to build a UP dump-capture
   kernel or specify maxcpus=1 option while loading dump-capture kernel.

>> +  multi-threads programs with it, such as parallel dump feature of
>> +  makedumpfile. Otherwise, the multi-threads program may have a great
>> +  performance degradation. To bring up a SMP dump-capture kernel, we
>> +  should specify maxcpus\nr_cpus and disable_cpu_apic=[X] options while
>> +  loading it.
>> +
>>   * For s390x there are two kdump modes: If a ELF header is specified with
>>     the elfcorehdr= kernel parameter, it is used by the kdump kernel as it
>>     is done on all other architectures. If no elfcorehdr= kernel parameter is
>> --
>> 1.8.3.1
>>
>>
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>
>


-- 
Thanks
Zhou



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
