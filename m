Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cvOeV-0005yc-RU
 for kexec@lists.infradead.org; Tue, 04 Apr 2017 13:37:49 +0000
Received: by mail-wr0-x22b.google.com with SMTP id w11so213589263wrc.3
 for <kexec@lists.infradead.org>; Tue, 04 Apr 2017 06:37:22 -0700 (PDT)
Date: Tue, 4 Apr 2017 14:37:19 +0100
From: Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: kexec regression since 4.9 caused by efi
Message-ID: <20170404133719.GE19827@codeblueprint.co.uk>
References: <20170308201616.GC8598@vader>
 <20170309063806.GB17257@dhcp-128-65.nay.redhat.com>
 <20170309095408.GA17883@vader>
 <20170313073748.GA6332@dhcp-128-65.nay.redhat.com>
 <20170316124132.GF6261@codeblueprint.co.uk>
 <20170317020951.GA3942@dhcp-128-65.nay.redhat.com>
 <20170317133232.GI6261@codeblueprint.co.uk>
 <20170320021412.GA3793@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170320021412.GA3793@dhcp-128-65.nay.redhat.com>
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
Cc: linux-efi@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com

On Mon, 20 Mar, at 10:14:12AM, Dave Young wrote:
> 
> Matt, I'm fine if you prefer to capture the range checking errors.
> Would you like me to post it or just you send it out?

Can you please send out the patch with the minimal change to
efi_arch_mem_reserve() and we'll get it into urgent ASAP.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
