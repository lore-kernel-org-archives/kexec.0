Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gH4Zq-0006bk-Iz
 for kexec@lists.infradead.org; Mon, 29 Oct 2018 10:15:20 +0000
Date: Mon, 29 Oct 2018 11:15:05 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] arm64: If 'getrandom' syscall fails, don't error out -
 just warn and proceed.
Message-ID: <20181029101505.kb2lo7xaxugyadz4@verge.net.au>
References: <1540239620-29321-1-git-send-email-bhsharma@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1540239620-29321-1-git-send-email-bhsharma@redhat.com>
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
Cc: takahiro.akashi@linaro.org, bhupesh.linux@gmail.com, kexec@lists.infradead.org

On Tue, Oct 23, 2018 at 01:50:20AM +0530, Bhupesh Sharma wrote:
> For calculating the random 'kaslr-seed' value to be passed to the
> secondary kernel (kexec or kdump), we invoke the 'getrandom' syscall
> inside 'setup_2nd_dtb()' function.
> 
> Normally on most arm64 systems this syscall doesn't fail when the
> initrd scriptware (which arms kdump service) invokes the same.
> However, recently I noticed that on the 'hp-moonshot' arm64 boards,
> we have an issue with the newer kernels which causes the same
> to fail. As a result, the kdump service fails and we are not able
> to use the kdump infrastructure just after boot. As expected, once the
> random pool is sufficiently populated and we launch the kdump service
> arming scripts again (manually), then the kdump service is properly
> enabled.
> 
> Lets handle the same, by not error'ing out if 'getrandom' syscall fails.
> Rather lets warn the user and proceed further by setting the
> 'kaslr-seed' value as 0 for the secondary kernel - which implies that it
> boots in a 'nokaslr' mode.
> 
> Tested on my 'hp-moonshot' and 'qualcomm-amberwing' arm64 boards.
> 
> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
