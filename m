Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1cnmfr-00012P-RC
 for kexec@lists.infradead.org; Tue, 14 Mar 2017 13:39:41 +0000
Date: Tue, 14 Mar 2017 14:39:13 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] x86/x86_64: Fix format warning with die()
Message-ID: <20170314133913.GA14040@verge.net.au>
References: <3809295c06f9318c380620ccb6b47bd82a43c3a6.1489493828.git.panand@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3809295c06f9318c380620ccb6b47bd82a43c3a6.1489493828.git.panand@redhat.com>
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
To: Pratyush Anand <panand@redhat.com>
Cc: dyoung@redhat.com, kexec@lists.infradead.org, bhe@redhat.com

On Tue, Mar 14, 2017 at 05:59:22PM +0530, Pratyush Anand wrote:
> Fedora koji uses gcc version 7.0.1-0.12.fc27, and it generates a build
> warning
> 
>    kexec/arch/i386/kexec-elf-x86.c:299:3: error: format not a string
>    literal and no format arguments [-Werror=format-security]
>        die(error_msg);
>        ^~~
>     cc1: some warnings being treated as errors
> 
> error_msg can have a format specifier as well in string. In such cases,
> if there is no other arguments for the format variable then code will
> try to access a non existing argument. Therefore, use 1st argument as
> format specifier for string print and pass error_msg as the string to be
> printed.
> 
> While doing that,also use const qualifier before "char *error_msg".
> 
> Signed-off-by: Pratyush Anand <panand@redhat.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
