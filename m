Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a9Q70-0002yh-H9
 for kexec@lists.infradead.org; Thu, 17 Dec 2015 04:24:19 +0000
Date: Thu, 17 Dec 2015 09:53:53 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH] arm: ramdisk uimage support for arm
Message-ID: <20151217042353.GC1525@dhcppc13.redhat.com>
References: <56711B8C.9090407@powersoft.it>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <56711B8C.9090407@powersoft.it>
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
To: Michele Dionisio <michele.dionisio@powersoft.it>
Cc: kexec@lists.infradead.org

Hi Michele,

On 16/12/2015:09:06:36 AM, Michele Dionisio wrote:
> +/*
> + * Load the ramdisk into buffer.
> + *  If the supplied image is in uImage format use
> + *  uImage_load() to read the payload from the image.
> + */
> +char *slurp_ramdisk_arm(const char *filename, off_t *r_size)

This function is exactly as slurp_ramdisk_ppc(). So, why not we have a common
slurp_ramdisk() function usable for both arm and ppc.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
