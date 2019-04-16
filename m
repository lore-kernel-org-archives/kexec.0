Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hGKf9-0001X2-LB
 for kexec@lists.infradead.org; Tue, 16 Apr 2019 09:46:00 +0000
Date: Tue, 16 Apr 2019 11:45:54 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190416094554.GF27892@zn.tnic>
References: <C54C5A30-62D9-45C4-8036-88D255FD92A1@alien8.de>
 <20190411125822.GE30080@zn.tnic>
 <20190412025416.GA11070@jeru.linux.bs1.fc.nec.co.jp>
 <20190412084956.GC19808@zn.tnic> <20190412133528.GD19808@zn.tnic>
 <cc2c1dbe-4fb3-fb7d-0540-c04734fc15cb@ce.jp.nec.com>
 <20190415090717.GA29317@zn.tnic> <20190415102525.GB29317@zn.tnic>
 <23309b73-d135-a207-564b-6003cee39184@ce.jp.nec.com>
 <4dbbbb4b-7af9-bd98-b567-890407a15cd1@ce.jp.nec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4dbbbb4b-7af9-bd98-b567-890407a15cd1@ce.jp.nec.com>
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
To: Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>, Kairui Song <kasong@redhat.com>, Baoquan He <bhe@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dave Young <dyoung@redhat.com>

On Mon, Apr 15, 2019 at 11:14:34PM +0000, Junichi Nomura wrote:
> I see kexec is only supported on 64bit kernel. But are we sure
> we don't need to support kexec on EFI32 + 64bit kernel?
> 
> I don't have such an environment and as far as I tried with OVMF i386
> and KVM guest, that combination doesn't work reliably even with v5.0.

What does that mean exactly?

If it can be fixed, we can try to.

> So I suppose people don't care.

There's that.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
