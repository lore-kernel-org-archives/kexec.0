Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KdvcN-0006od-Oz
	for kexec@lists.infradead.org; Thu, 11 Sep 2008 23:30:32 +0000
Date: Fri, 12 Sep 2008 09:30:30 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [kexec patch 1/2] Fix build warnings
Message-ID: <20080911233028.GG10635@verge.net.au>
References: <48C8771A.2000806@am.sony.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <48C8771A.2000806@am.sony.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: kexec@lists.infradead.org, Cell Broadband Engine OSS Development <cbe-oss-dev@ozlabs.org>

On Wed, Sep 10, 2008 at 06:40:42PM -0700, Geoff Levand wrote:
> Fix these 64 bit build warnings:
> 
>  kexec/firmware_memmap.c:241: warning: format '%d' expects type 'int', but argument 3 has type 'size_t'
>  kexec/crashdump-elf.c:160: warning: format '%llx' expects type 'long long unsigned int', but argument 4 has type 'Elf64_Off'
>  kexec/crashdump-elf.c:160: warning: format '%llx' expects type 'long long unsigned int', but argument 5 has type 'Elf64_Addr'
>  kexec/crashdump-elf.c:160: warning: format '%llx' expects type 'long long unsigned int', but argument 6 has type 'Elf64_Addr'
>  kexec/crashdump-elf.c:160: warning: format '%llx' expects type 'long long unsigned int', but argument 7 has type 'Elf64_Xword'
>  kexec/crashdump-elf.c:160: warning: format '%llx' expects type 'long long unsigned int', but argument 8 has type 'Elf64_Xword'
> 
> Tested on PS3 (ppc64) with 32 and 64 bit builds. 

Thanks Geoff, applied.

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
