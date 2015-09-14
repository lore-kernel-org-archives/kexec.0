Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZbWDN-0000gb-Gw
 for kexec@lists.infradead.org; Mon, 14 Sep 2015 16:02:46 +0000
Message-ID: <82a169eb513c54ef5ab49f4c78531752.squirrel@www.codeaurora.org>
In-Reply-To: <CAHM4w1=aLOKY3PebMNb7cxWM_=n3TUJYB1WSvqrmMT6rQ+hRKg@mail.gmail.com>
References: <20150627082256.GE21646@localhost.localdomain>
 <ddc87d025100347122b078b5104ec88c.squirrel@www.codeaurora.org>
 <20150703043241.GC21990@dhcppc13.redhat.com>
 <2c41ac3516494a1cc5d05462494b333b.squirrel@www.codeaurora.org>
 <c0ce0a0ea4482e9fca97b5c811f4693b.squirrel@www.codeaurora.org>
 <d0d13b96c02d5b54afcda30723667dab.squirrel@www.codeaurora.org>
 <20150820112150.GA26132@dhcppc13.redhat.com>
 <cd279166af08eba11be211481f319ab8.squirrel@www.codeaurora.org>
 <20150821034433.GB26132@dhcppc13.redhat.com>
 <006bee38a745c1ca9199870ca8cc600b.squirrel@www.codeaurora.org>
 <20150822035445.GC3013@dhcppc13.redhat.com>
 <5053347ed9f8e4e245d8438b3a8c981d.squirrel@www.codeaurora.org>
 <797166011523512cf7099f14770922b4.squirrel@www.codeaurora.org>
 <bf24321255a60856d889590131daf69a.squirrel@www.codeaurora.org>
 <CAHM4w1=aLOKY3PebMNb7cxWM_=n3TUJYB1WSvqrmMT6rQ+hRKg@mail.gmail.com>
Date: Mon, 14 Sep 2015 16:02:23 -0000
Subject: Re: [PATCH] makedumpfile: Support ARM64
From: sgoel@codeaurora.org
MIME-Version: 1.0
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
To: Pratyush Anand <pratyush.anand@gmail.com>
Cc: Pratyush Anand <panand@redhat.com>, Timur Tabi <timur@codeaurora.org>, Azriel Samson <asamson@codeaurora.org>, kexec@lists.infradead.org, sgoel@codeaurora.org, virajm@codeaurora.org, ats-kumagai@wm.jp.nec.com

hi Pratyush,
 Most of the chages are translation level and architecture related. I was
able to get this working on Friday for 3 level tables on arm64. I am
trying to get this code back to you now.
Thanks,
Sameer

> HI Sameer,
>
>
> On Wed, Sep 9, 2015 at 4:02 AM,  <sgoel@codeaurora.org> wrote:
>> Hi Pratush,
>>  I added the mappings for PMD translations to the vtop function. This
>> helped in translating the address to physical. Issues seen:
>> 1. If PMD translates to a section. The physical translations does not
>> get
>> rid of the PMD flags. So, the physical address shows up as invalid and
>> code crashes when it tries to read this address from ELF.
>> 2. After treating this as a PTE table address, we see a compression of
>> around 50%.
>>
>
> Is it possible for you to share the modification you would have done
> on top of https://github.com/pratyushanand/makedumpfile.git:arm64_support.
> Actually, I have lost track of all the modifications you have done on
> top of my changes.
>
> I would like to review it closely this weekend and will suggest you
> whatever I find.
>
> ~Pratyush
>



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
