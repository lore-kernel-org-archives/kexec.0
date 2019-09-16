Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i9lGR-0002aX-Eb
 for kexec@lists.infradead.org; Mon, 16 Sep 2019 07:17:40 +0000
Date: Mon, 16 Sep 2019 09:17:28 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/2] Fix a compilation warning and a static check error
Message-ID: <20190916071728.53prtjga66sxejry@verge.net.au>
References: <20190910102150.7229-1-bhsharma@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190910102150.7229-1-bhsharma@redhat.com>
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
Cc: bhupesh.linux@gmail.com, kexec@lists.infradead.org

On Tue, Sep 10, 2019 at 03:51:48PM +0530, Bhupesh Sharma wrote:
> This patchset fixes two kexec-tools issues:
>  - Fixes a shifting error reported by cppcheck inside
>    'vmcore-dmesg/vmcore-dmesg.c'.
>  - Fixes a compilation warning in 'i386/kexec-mb2-x86.c'.

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
