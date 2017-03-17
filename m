Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cos00-0008K0-Vu
 for kexec@lists.infradead.org; Fri, 17 Mar 2017 13:33:01 +0000
Received: by mail-wm0-x230.google.com with SMTP id n11so16069062wma.0
 for <kexec@lists.infradead.org>; Fri, 17 Mar 2017 06:32:35 -0700 (PDT)
Date: Fri, 17 Mar 2017 13:32:32 +0000
From: Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: kexec regression since 4.9 caused by efi
Message-ID: <20170317133232.GI6261@codeblueprint.co.uk>
References: <20170308201616.GC8598@vader>
 <20170309063806.GB17257@dhcp-128-65.nay.redhat.com>
 <20170309095408.GA17883@vader>
 <20170313073748.GA6332@dhcp-128-65.nay.redhat.com>
 <20170316124132.GF6261@codeblueprint.co.uk>
 <20170317020951.GA3942@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170317020951.GA3942@dhcp-128-65.nay.redhat.com>
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

On Fri, 17 Mar, at 10:09:51AM, Dave Young wrote:
> 
> Matt, I think it should be fine although I think the md type checking in
> efi_mem_desc_lookup() is causing confusion and not easy to understand..
 
Could you make that a separate patch if you think of improvements
there?

> How about move the if chunk early like below because it seems no need
> to sanity check the addr + size any more if the md is still RUNTIME?

My original version did as you suggest, but I changed it because we
*really* want to know if someone tries to reserve a range that spans
regions. That would be totally unexpected and a warning about a
potential bug/issue.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
