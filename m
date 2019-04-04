Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hC3YN-00075j-GD
 for kexec@lists.infradead.org; Thu, 04 Apr 2019 14:41:20 +0000
Date: Thu, 4 Apr 2019 16:41:15 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190404144115.GE22539@zn.tnic>
References: <20190326135714.GG1867@zn.tnic>
 <20190327014852.GA3659@MiWiFi-R3L-srv>
 <73322ba9-e436-68db-7863-afd31607d969@ce.jp.nec.com>
 <20190328064343.GA1877@MiWiFi-R3L-srv>
 <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
 <20190328155256.GP22720@zn.tnic>
 <20190402102529.GA21698@jeru.linux.bs1.fc.nec.co.jp>
 <20190404073233.GC5708@dhcp-128-65.nay.redhat.com>
 <20190404122425.GC22539@zn.tnic>
 <20190404141241.GB7789@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190404141241.GB7789@dhcp-128-65.nay.redhat.com>
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
Cc: "x86@kernel.org" <x86@kernel.org>, "kasong@redhat.com" <kasong@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>, "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Junichi Nomura <j-nomura@ce.jp.nec.com>

On Thu, Apr 04, 2019 at 10:12:41PM +0800, Dave Young wrote:
> The early code hang can make people confused, it is hard to
> say what happens and not easy to debug.   But if we return 0 then kernel
> just continue to boot, and fail later because of no acpi root pointer, at
> least we can have some kernel boot log.

Is it clear from that boot log where we failed?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
