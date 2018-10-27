Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gGPwU-0006tY-Se
 for kexec@lists.infradead.org; Sat, 27 Oct 2018 14:52:00 +0000
Date: Sat, 27 Oct 2018 16:51:51 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to vmcoreinfo
Message-ID: <20181027145151.GA7338@nazgul.tnic>
References: <1263471c-a27d-a698-15f0-b5947f13ea93@redhat.com>
 <20181026182440.20a4b107@ezekiel.suse.cz>
 <20181026222517.GB26927@nazgul.tnic>
 <20181027081343.GA1884@MiWiFi-R3L-srv>
 <20181027091007.GB1046@nazgul.tnic>
 <20181027093917.GA14493@MiWiFi-R3L-srv>
 <20181027101221.GC1046@nazgul.tnic>
 <20181027110858.GB14493@MiWiFi-R3L-srv>
 <C5F8ED8E-F361-4C6C-B9E2-E3C8BCD8E050@alien8.de>
 <c55bef2a-b972-7e6e-b698-6ac1bc736046@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c55bef2a-b972-7e6e-b698-6ac1bc736046@redhat.com>
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
To: lijiang <lijiang@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, Petr Tesarik <ptesarik@suse.cz>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, dyoung@redhat.com

On Sat, Oct 27, 2018 at 10:41:56PM +0800, lijiang wrote:
> Actually, the value of 'sme_me_mask' is 0x800000000000 when SME is
> enabled, otherwise it is 0. That is to say, if the bit 47 is set, the
> bit number is also 0x800000000000 (1 << 47UL);

Yes, and you can simply copy the mask into your variable and export
that. Thinking about it more, though, it might be better if you instead
export a smaller value - not an u64 - and construct the mask in
userspace. I.e., a u8 which should be enough for your current purposes.

I say current because if it turns out we need to export more SME-related
info to userspace, exporting an u64 and then OR-ing in more information
in it would allow that. u8 not so much. So doing something like:

[ misc	   ][ enc bit  ][ other misc SME info 				      ]
0000_0000_0000_0000_1000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000
63   59   55   51   47   43   39   35   31   27   23   19   15   11   7    3

would allow for exporting that additional info.

Especially if we want to use VMCOREINFO for more than kexec things.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
