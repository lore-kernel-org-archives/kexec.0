Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TTsD5-0007sp-99
 for kexec@lists.infradead.org; Thu, 01 Nov 2012 10:41:16 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <508FDEF3.8030601@hitachi.com> <20121030143750.GF2290@redhat.com>
 <50912CFB.5000508@hitachi.com> <20121031141426.GE1865@redhat.com>
 <50924FCD.2020100@hitachi.com>
Date: Thu, 01 Nov 2012 03:40:56 -0700
In-Reply-To: <50924FCD.2020100@hitachi.com> (Mitsuhiro Tanino's message of
 "Thu, 01 Nov 2012 19:32:45 +0900")
Message-ID: <87vcdpk3lz.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [Patch 0/2] Exclude hwpoison page from vmcore dump
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
To: Mitsuhiro Tanino <mitsuhiro.tanino.gm@hitachi.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>

Mitsuhiro Tanino <mitsuhiro.tanino.gm@hitachi.com> writes:

> Hi Vivek,
>
> (2012/10/31 23:14), Vivek Goyal wrote:
>> If hwpoision functionality is not available in hardware, then respective
>> bit will not be even set in struct page and it will be saved by default.
>> So it should not matter whether hardware has hwpoision functionality
>> or not.
>
> Thanks, I understand.
>
>> I think that removing hwpoisno pages by default makes sense. If somebody
>> does have a reasonable case of not doing so, then we could either
>> introduce anther filtering level (based on type) or add another command
>> line option like (--no-hwposion-filtering) etc.
>
> I agree with you.
> If somebody requests to support for disabling the filter of hwpoison pages,
> this option will be discussed.


I agree.  If we are performing filtering filtering out of poisoned pages
seems very reasonable.  So ack on the basic concept.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
