Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1Rl53I-0004vQ-Pk
 for kexec@lists.infradead.org; Wed, 11 Jan 2012 20:45:45 +0000
Date: Thu, 12 Jan 2012 05:45:39 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kdump: Define KEXEC_NOTE_BYTES arch specific for s390x
Message-ID: <20120111204539.GB23752@verge.net.au>
References: <1326281412.2819.3.camel@br98xy6r>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1326281412.2819.3.camel@br98xy6r>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, kexec@lists.infradead.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, schwidefsky@de.ibm.com, akpm@linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

On Wed, Jan 11, 2012 at 12:30:12PM +0100, Michael Holzheu wrote:
> From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> 
> kdump only allocates memory for the prstatus ELF note. For s390x,
> besides of prstatus multiple ELF notes for various different register
> types are stored. Therefore the currently allocated memory is not
> sufficient. With this patch the KEXEC_NOTE_BYTES macro can be
> defined by architecture code and for s390x it is set to the correct
> size now.
> 
> Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>

This seems reasonable to me.

Reviewed-by: Simon Horman <horms@verge.net.au>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
