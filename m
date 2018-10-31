Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gHnSy-0000ZQ-3h
 for kexec@lists.infradead.org; Wed, 31 Oct 2018 10:11:14 +0000
Date: Wed, 31 Oct 2018 11:10:54 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to vmcoreinfo
Message-ID: <20181031101054.GB15955@zn.tnic>
References: <15897206-c1a6-ced6-3a1b-f71da8fc9c83@redhat.com>
 <20181029114414.GA11408@MiWiFi-R3L-srv>
 <90385882-7fd1-a674-ec5a-19bd42471a5e@redhat.com>
 <20181029134918.GB32150@zn.tnic>
 <699ab34e-1373-582d-4e58-e76bd57ec34f@redhat.com>
 <20181030050900.GA25987@dhcp-128-65.nay.redhat.com>
 <20181030091542.GD32102@zn.tnic>
 <20181030092314.GC14493@MiWiFi-R3L-srv>
 <dcbc925f-6935-6a34-fde1-7aa1ea378891@redhat.com>
 <20181031024748.GA2058@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181031024748.GA2058@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: lijiang <lijiang@redhat.com>, Baoquan He <bhe@redhat.com>, Petr Tesarik <ptesarik@suse.cz>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Kazuhito Hagio <khagio@redhat.com>, mingo@redhat.com, tglx@linutronix.de

On Wed, Oct 31, 2018 at 10:47:48AM +0800, Dave Young wrote:
> It is a mist only a few kdump people know them, documenting them will help
> people to understand and review. It will also be clearer instead of
> digging into code?

Wholeheartedly agreed. Especially if people start using vmcoreinfo for
other stuff, like live debugging:

https://lkml.kernel.org/r/1540593788-28181-1-git-send-email-bhsharma@redhat.com

> The document can briefly explain what is vmcoreinfo, why we need it, and
> some background info.  Then list the exported values with some
> classifying by core kernel, arch related,  string or number etc.  For
> most of them like Baoquan said no need more explanation, but add
> explanations for something if needed like this sme mask.

And add explanations for *all* of them!

If this becomes an API, then it better be documented.

> But I think this can be done separately instead of blocking this patch.

We have three months to the next merge window - I'm sure you guys can do
both. :-)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
