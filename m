Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RQtq0-00087f-Un
 for kexec@lists.infradead.org; Thu, 17 Nov 2011 04:44:38 +0000
Message-ID: <4EC491B3.705@redhat.com>
Date: Thu, 17 Nov 2011 12:46:43 +0800
From: Dave Young <dyoung@redhat.com>
MIME-Version: 1.0
Subject: Re: Crash during vmcore_init
References: <1318376345.2050.20.camel@boudreau> <j9r5m5$b18$1@dough.gmane.org>
 <1321296650.2066.17.camel@boudreau> <4EC21F67.10905@redhat.com>
 <1321396371.4198.5.camel@boudreau> <4EC31E55.6040809@redhat.com>
 <1321467647.2137.4.camel@boudreau> <4EC47FCA.5090908@redhat.com>
 <CAOS58YMOuJrvGxE1VxsU=ZPTLgY60HDJoLFjTowx9ZApUQ3tTw@mail.gmail.com>
In-Reply-To: <CAOS58YMOuJrvGxE1VxsU=ZPTLgY60HDJoLFjTowx9ZApUQ3tTw@mail.gmail.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Tejun Heo <tj@kernel.org>
Cc: WANG Cong <xiyou.wangcong@gmail.com>, kexec@lists.infradead.org, tim@edgecast.com, linux-kernel@vger.kernel.org

On 11/17/2011 12:34 PM, Tejun Heo wrote:

> Hello,
> 
> On Wed, Nov 16, 2011 at 7:30 PM, Dave Young <dyoung@redhat.com> wrote:
>> This addr is converted to an invalid phys address,
> 
> I'm a bit lost on the context here. Who's calling per_cpu_ptr_to_phys()?


It's drivers/base/cpu.c : show_crash_notes()

> 
>> looking the code below:
>>       if (in_first_chunk) {
>>                if (!is_vmalloc_addr(addr))
>>                        return __pa(addr);
>>                else
>>                        return page_to_phys(vmalloc_to_page(addr));
>>        } else
>>                return page_to_phys(pcpu_addr_to_page(addr));
>>
>> I dont understand per cpu allocation well, if addr is not in first chunk
>> then it should be in vmalloc area?
> 
> Yes, it is. First chunk can be embedded in the kernel linear address
> space but from the second one, it's always set up from the top of the
> vmalloc area with the same offset layout as the first chunk.


in this case ffff880667c19ad0 fall out of vmalloc area and it's not in
first chunk also.

> 
>> Tejun, do you have any idea about this?
> 
> Can you please tell me how to reproduce the problem? I'll try to find
> out what's going on.


make sure kernel support CRASH DUMP, then cat
/sys/devices/system/cpu/cpu[x]/crash_notes

Tim Hartrick <tim@edgecast.com> reported the problem when test kdump.
But I can not reproduce this. I think tim can help to test

> 
> Thanks.
> 



-- 
Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
