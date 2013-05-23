Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UfaiY-000641-Bg
 for kexec@lists.infradead.org; Thu, 23 May 2013 18:58:27 +0000
Date: Thu, 23 May 2013 14:57:38 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2 1/3] kdump: Introduce ELF header in new memory feature
Message-ID: <20130523185738.GM2779@redhat.com>
References: <1369245517-16204-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <1369245517-16204-2-git-send-email-holzheu@linux.vnet.ibm.com>
 <20130523174127.GA12290@redhat.com>
 <20130523205241.4b9e4fde@holzheu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130523205241.4b9e4fde@holzheu>
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
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, kexec@lists.infradead.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org

On Thu, May 23, 2013 at 08:52:41PM +0200, Michael Holzheu wrote:
> Hello Vivek,
> 
> Thanks for your reply. I will integrate your feedback into the v3 patch
> set and will make the following changes:
> 
> - Get rid of ELFCORE_ADDR_NEWMEM (sorry for that:)
> - Make read_from_crash_header() only read from kernel
> - Move read_from_crash_header() to weak function
>   arch_read_from_crash_header()
> - Implement read_from_crash_header() strong function for s390
> - Set elfcorehdr_addr to address of new ELF header

Thanks Michael. Also note, that hatayama has posted a  new version (V8)
of his mmap() patches. So you can rebase your changes on top of V8.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
