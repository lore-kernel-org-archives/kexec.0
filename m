Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZwKmu-0002ln-Ld
 for kexec@lists.infradead.org; Wed, 11 Nov 2015 02:05:29 +0000
Date: Wed, 11 Nov 2015 11:05:03 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v3] kexec: determine size of block device
Message-ID: <20151111020503.GD12527@verge.net.au>
References: <1447062176-13234-1-git-send-email-andreas.fenkart@dev.digitalstrom.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1447062176-13234-1-git-send-email-andreas.fenkart@dev.digitalstrom.org>
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
To: Andreas Fenkart <afenkart@gmail.com>
Cc: Andreas Fenkart <andreas.fenkart@dev.digitalstrom.org>, kexec@lists.infradead.org

On Mon, Nov 09, 2015 at 10:42:56AM +0100, Andreas Fenkart wrote:
> starting 'kexec -l /dev/mmcblk0p1' fails since the size of
> a block device can not be determined with stat
> 
> Signed-off-by: Andreas Fenkart <andreas.fenkart@dev.digitalstrom.org>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
