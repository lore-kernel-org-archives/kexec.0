Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dCh0T-0001vI-B9
 for kexec@lists.infradead.org; Mon, 22 May 2017 06:39:57 +0000
Received: by mail-pf0-f174.google.com with SMTP id 9so72594549pfj.1
 for <kexec@lists.infradead.org>; Sun, 21 May 2017 23:39:33 -0700 (PDT)
Subject: Re: [PATCH] kexec/kdump: Minor Documentation updates for arm64 and
 Image
References: <1495085600-2645-1-git-send-email-Bharat.Bhushan@nxp.com>
 <20170518055914.GC4059@dhcp-128-65.nay.redhat.com>
 <20170519034514.GA4283@fireball>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <2ed84f9f-76c8-62eb-36b5-e97568ba3a2e@redhat.com>
Date: Mon, 22 May 2017 12:09:26 +0530
MIME-Version: 1.0
In-Reply-To: <20170519034514.GA4283@fireball>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, Dave Young <dyoung@redhat.com>, Bharat Bhushan <Bharat.Bhushan@nxp.com>, bhe@redhat.com, vgoyal@redhat.com, corbet@lwn.net, kexec@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org



On Friday 19 May 2017 09:15 AM, AKASHI Takahiro wrote:
>>> +to load dump-capture kernel.
>>> +
>>> +   kexec -p <dump-capture-kernel-Image> \
>>> +   --initrd=<initrd-for-dump-capture-kernel> \
>>> +   --append="root=<root-dev> <arch-specific-options>"
>> For uncompressed Image, dtb is not necessary?
> Just for clarification, dtb is optional for both vmlinux and Image
> on arm64. (This means you can specify it if you want.)
> But this is also true for initrd and append(command line) to some extent.

Yes, I agree.
>
> More precisely, whether these parameters are optional or not will
> depend on architectures, not formats, I believe.

May be not architecture, rather a distro environment.

For example, we should be able to work without --initrd for any arch if kernel 
has been compiled by configuring CONFG_INITRAMFS_SOURCE.

~Pratyush


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
