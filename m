Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([2406:a000:f000:9500::1])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1Qol7U-0007kc-Bx
	for kexec@lists.infradead.org; Wed, 03 Aug 2011 23:45:01 +0000
Date: Thu, 4 Aug 2011 08:44:47 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] fix Xen detection for xenfs in pv_ops kernel
Message-ID: <20110803234447.GN17246@verge.net.au>
References: <20110803180705.GA22296@aepfle.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110803180705.GA22296@aepfle.de>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Olaf Hering <olaf@aepfle.de>
Cc: kexec@lists.infradead.org

On Wed, Aug 03, 2011 at 08:07:05PM +0200, Olaf Hering wrote:
> The pv_ops kernel in mainline Linux provides xenfs which has to be
> mounted at /proc/xen.  It creates /proc/xen/capabilities unconditionally
> which makes it impossible to distinguish PVonHVM guests from PV guests.
> Use code from xen-detect.c to check wether kexec runs on a PV guest.
> Without this change PVonHVM guests will be detected incorrectly as plain
> PV guests.

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
