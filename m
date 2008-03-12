Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from outbound-va3.frontbridge.com ([216.32.180.16]
	helo=outbound1-va3-R.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JZJhe-00058u-1r
	for kexec@lists.infradead.org; Wed, 12 Mar 2008 05:40:38 +0000
Message-ID: <47D76CC9.5080200@am.sony.com>
Date: Tue, 11 Mar 2008 22:40:25 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
Subject: Re: Fwd: Kexec support for PS3 (ppc64)
References: <C5065F118AFB3D478B052FC1E9810D9CA9041B@tec-mail.ttec.soc-soft.com>	<4574cb3d0803062155k7da6be9al30ee3f35d01f9f0@mail.gmail.com>	<47D19114.1090700@am.sony.com>	<4574cb3d0803110325u759a411ckbae3ff69557b0230@mail.gmail.com>	<47D6B92D.2020205@am.sony.com>
	<47D6D406.8050209@am.sony.com>	<47D73003.8060208@bluelane.com>
	<47D7349E.90409@am.sony.com> <20080312052509.GC409@in.ibm.com>
In-Reply-To: <20080312052509.GC409@in.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: mohan@in.ibm.com
Cc: Rajasekaran P <rajasekaran83@gmail.com>, piet@bluelane.com, kexec@lists.infradead.org

On 03/11/2008 10:25 PM, Mohan Kumar M wrote:
> On Tue, Mar 11, 2008 at 06:40:46PM -0700, Geoff Levand wrote:
>> When the first stage kernel goes down it releases all hypervisor
>> resources so that whatever boots next can successful open those
>> resources.  The frame buffer is one of those resources that are
>> released, and after it is, there will be no more output to the
>> display until the second stage image brings up its display.  It
>> is not a matter of adding print statements or string formatting.
>>
> 
> Geoff,
> 
> What about using Hypervisor call H_PUT_TERM_CHAR?
> 
> I used this call to debug the first kernel kexec shutdown sequence.

That is for the IBM pSeries.  I can't see how it would work
on the ps3.  ps3 hvcalls are in lv1calls.h.

Just out of curiosity, how exactly did you 'use' it?

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
