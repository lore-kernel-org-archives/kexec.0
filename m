Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.89 #1 (Red Hat Linux))
 id 1eg3lJ-0004mc-EP
 for kexec@lists.infradead.org; Mon, 29 Jan 2018 07:21:55 +0000
Date: Mon, 29 Jan 2018 08:21:35 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH kexec-tools] x86: use old screen_info if needed
Message-ID: <20180129072135.pyzaawl7i6ny3piv@verge.net.au>
References: <20180128055231.GA1744@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180128055231.GA1744@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org

On Sun, Jan 28, 2018 at 01:52:31PM +0800, Dave Young wrote:
> With modern drm/kms graphic driver kexec-tools does not setup screen_info
> correctly so one will only see screen output after those drm drivers
> reinitializing after rebooting. Copying the old screen info from original
> boot_params will help during my test, although it could not work for some
> potential cases, but it is not worse than before.  This has been used in
> the kernel kexec_file_load.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
