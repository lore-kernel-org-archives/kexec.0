Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gFYDa-0000Jj-DN
 for kexec@lists.infradead.org; Thu, 25 Oct 2018 05:30:23 +0000
Date: Thu, 25 Oct 2018 13:29:43 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] arm64: If 'getrandom' syscall fails, don't error out -
 just warn and proceed.
Message-ID: <20181025052943.GA11755@dhcp-128-65.nay.redhat.com>
References: <1540239620-29321-1-git-send-email-bhsharma@redhat.com>
 <20181023013145.GA10791@dhcp-128-65.nay.redhat.com>
 <CACi5LpPxqqc93YT9_444g0J+WwiO1sy1a_rKYq8wtV=zKr+wwA@mail.gmail.com>
 <20181024070439.GC3094@dhcp-128-65.nay.redhat.com>
 <CACi5LpNpuwoXAM6cAGnjin-a6r906d4O+sZw7c6NXw4ziQq-rg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACi5LpNpuwoXAM6cAGnjin-a6r906d4O+sZw7c6NXw4ziQq-rg@mail.gmail.com>
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, kexec mailing list <kexec@lists.infradead.org>, Simon Horman <horms@verge.net.au>

Hi Bhupesh,

On 10/24/18 at 02:01pm, Bhupesh Sharma wrote:
[snip]
> Now, passing "nokaslr" explicitly in bootargs (whether of a primary or
> secondary kernel itself), is a different case altogether from the
> above error. If the primary kernel is boot'ed with "nokaslr" the
> 'kexec-tools' will not prepare the 'kaslr-seed' property for the
> secondary kernel. Also if "nokaslr" is being passed in secondary
> kernel's booatrags, the above error will be printed only if
> getrandom() syscall failed in NON_BLOCK mode.

I understand your point about kexec-tools and 2nd kernel are different
cases, but from user point of view, these two cases are combined.
If one does not want kaslr then kexec-tools can just skip getting the
seeds at all. 

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
