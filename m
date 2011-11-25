Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RTsbK-0001ot-U2
 for kexec@lists.infradead.org; Fri, 25 Nov 2011 10:01:48 +0000
Message-ID: <4ECF680C.7060606@redhat.com>
Date: Fri, 25 Nov 2011 18:03:56 +0800
From: Dave Young <dyoung@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec: do not call kmsg_dump in crashdump
References: <20111125081959.GA2505@darkstar.nay.redhat.com>
 <CAM_iQpW7WXeUihgbJneJUJ1GAMzXfONfV69dpqeRbUt_781M=Q@mail.gmail.com>
In-Reply-To: <CAM_iQpW7WXeUihgbJneJUJ1GAMzXfONfV69dpqeRbUt_781M=Q@mail.gmail.com>
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
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: kexec@lists.infradead.org, ebiederm@xmission.com, linux-kernel@vger.kernel.org

On 11/25/2011 05:32 PM, Cong Wang wrote:

> On Fri, Nov 25, 2011 at 4:19 PM, Dave Young <dyoung@redhat.com> wrote:
>> mtd/ram oops dumper will make more functions envolved. In case crash kexec,
>> we should avoid kmsg dumper to ensure crashdump success.
>>
>> kill kmsg_dump callback while crash dumping
> 
> https://lkml.org/lkml/2011/2/1/33


Thanks for give the link. So it's intend to be that.

I'm still confused with the KMSG_DUMP_KEXEC.

crash_kexec()
	kmsg_dump(KMSG_DUMP_KEXEC)
kmsg_dump(KMSG_DUMP_PANIC)

Looks like it's equal to original logic, isn't it?

kmsg_dump(anything);
crash_kexec()

So why intruduce KMSG_DUMP_KEXEC? why not just kmsg_dump before crash_kexec?

thoughts?

-- 
Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
