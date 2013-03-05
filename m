Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UCgql-0005Mo-QP
 for kexec@lists.infradead.org; Tue, 05 Mar 2013 01:39:28 +0000
Date: Tue, 5 Mar 2013 10:39:24 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v9 0/7] kexec: put bzImage and ramdisk above 4G for x86
 64bit
Message-ID: <20130305013924.GC16128@verge.net.au>
References: <1361506076-13112-1-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1361506076-13112-1-git-send-email-yinghai@kernel.org>
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
To: Yinghai Lu <yinghai@kernel.org>
Cc: kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>

On Thu, Feb 21, 2013 at 08:07:49PM -0800, Yinghai Lu wrote:
> Now we have limit kdump reserved under 896M, because kexec has the limitation.
> and also bzImage need to stay under 4g.
> 
> kernel parts changes get merged to linus tree already.

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
