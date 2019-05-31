Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hWdr0-0006qV-UR
 for kexec@lists.infradead.org; Fri, 31 May 2019 09:29:40 +0000
Date: Fri, 31 May 2019 11:29:36 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] x86: Handle 64bit framebuffer memory address properly
Message-ID: <20190531092935.sfpbxeu7uquogtd5@verge.net.au>
References: <20181123092633.16111-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181123092633.16111-1-kasong@redhat.com>
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
To: Kairui Song <kasong@redhat.com>
Cc: dyoung@redhat.com, kexec@lists.infradead.org

On Fri, Nov 23, 2018 at 05:26:33PM +0800, Kairui Song wrote:
> In a EFI system, the frame buffer address is 64bit, so currently
> if the address is beyound 4G, kexec will set wrong address due to
> truncate.
> 
> Linux kernel commit ae2ee627dc87 ('efifb: Add support for 64-bit
> frame buffer addresses') added support for 64bit frame buffer
> address, an 'ext_lfb_base' field is added as the upper 32-bits of
> the frame buffer, and introduced a new capability flag
> 'VIDEO_TYPE_CAPABILITY_64BIT_BASE' to indicate if the extend field is
> used.
> 
> This patch adopts this change, set proper extent address and capability
> flag when the address is beyound 4G.
> 
> Signed-off-by: Kairui Song <kasong@redhat.com>

Sorry for letting this slip through the cracks.
Please let me know if this is still relevant.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
