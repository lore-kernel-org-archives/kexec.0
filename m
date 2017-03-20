Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cpmqr-00050Q-9a
 for kexec@lists.infradead.org; Mon, 20 Mar 2017 02:15:18 +0000
Date: Mon, 20 Mar 2017 10:14:12 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: kexec regression since 4.9 caused by efi
Message-ID: <20170320021412.GA3793@dhcp-128-65.nay.redhat.com>
References: <20170308201616.GC8598@vader>
 <20170309063806.GB17257@dhcp-128-65.nay.redhat.com>
 <20170309095408.GA17883@vader>
 <20170313073748.GA6332@dhcp-128-65.nay.redhat.com>
 <20170316124132.GF6261@codeblueprint.co.uk>
 <20170317020951.GA3942@dhcp-128-65.nay.redhat.com>
 <20170317133232.GI6261@codeblueprint.co.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170317133232.GI6261@codeblueprint.co.uk>
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
To: Matt Fleming <matt@codeblueprint.co.uk>
Cc: linux-efi@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com

On 03/17/17 at 01:32pm, Matt Fleming wrote:
> On Fri, 17 Mar, at 10:09:51AM, Dave Young wrote:
> > 
> > Matt, I think it should be fine although I think the md type checking in
> > efi_mem_desc_lookup() is causing confusion and not easy to understand..
>  
> Could you make that a separate patch if you think of improvements
> there?

Duplicate the lookup function is indeed a little ugly, will do it when I
have a better idea, we can leave it as is since it works.

> 
> > How about move the if chunk early like below because it seems no need
> > to sanity check the addr + size any more if the md is still RUNTIME?
> 
> My original version did as you suggest, but I changed it because we
> *really* want to know if someone tries to reserve a range that spans
> regions. That would be totally unexpected and a warning about a
> potential bug/issue.

Matt, I'm fine if you prefer to capture the range checking errors.
Would you like me to post it or just you send it out?

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
