Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UnZ9f-0006dM-S5
 for kexec@lists.infradead.org; Fri, 14 Jun 2013 18:55:24 +0000
Date: Fri, 14 Jun 2013 14:54:54 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v5 0/5] kdump: Allow ELF header creation in new kernel
Message-ID: <20130614185454.GM12023@redhat.com>
References: <1370624161-2298-1-git-send-email-holzheu@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1370624161-2298-1-git-send-email-holzheu@linux.vnet.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, kexec@lists.infradead.org, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>

On Fri, Jun 07, 2013 at 06:55:56PM +0200, Michael Holzheu wrote:

[..]
> In this patch series I did not include the discussed ELF header swap trick
> patch because with the ELF header read functions this patch currently is
> not necessary.

Michael,

Would be good to this change atleast in a separate patch series so that
we have common mechanism across arches and understanding code becomes
easier.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
