Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
 id 1hnLxq-0007YP-4e
 for kexec@lists.infradead.org; Tue, 16 Jul 2019 11:49:47 +0000
Date: Tue, 16 Jul 2019 13:49:42 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 0/4] kexec/arm64: Add support for zlib compressed
 kernel images (Image.gz)
Message-ID: <20190716114942.7ufsup2eyco4pxax@verge.net.au>
References: <1563170576-13134-1-git-send-email-bhsharma@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1563170576-13134-1-git-send-email-bhsharma@redhat.com>
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

On Mon, Jul 15, 2019 at 11:32:52AM +0530, Bhupesh Sharma wrote:
> Changes since v1:
> ----------------
> (v1 can be viewed here: http://lists.infradead.org/pipermail/kexec/2019-July/023288.html)
>  - Fixed the potential file descriptor leakage code legs pointed out by
>    Simon.
>  - Ran Valgrind to make sure no potential memory leakage issues are
>    introduced by this patchset.
> 
> This patchset adds the support for zlib compressed kernel images
> (Image.gz) for arm64 kexec-tools.
> 
> This was discussed a bit with the arm64 kernel maintainers (see [0]) and
> after discussing the pros and cons of adding this support in
> kernel-space v/s in user-space, we decided it makes more sense to add
> this support to the user-space kexec-tools.
> 
> Note that this series adds support for unsigned arm64 Image.gz files
> only as signing an Image.gz type file is not a easy implementation from
> kexec-tools p-o-v. Also even standard signing tools like sbsign fail to
> recongize the Image.gz format:
> 
>  $ sbsign --key certs/signing_key.pem  --cert certs/signing_key.pem Image.gz
>    Invalid DOS header magic
> 
> ... because that gzip file isn't a PE32+ that can be loaded by UEFI.
> So I will work on the same in coming days and try to send a RFC
> patchset for the same later on.
> 
> [0]. http://lists.infradead.org/pipermail/kexec/2019-June/023156.html

Thanks, applied for inclusion in v2.0.20.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
