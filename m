Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Pxv7t-0004U8-Iw
	for kexec@lists.infradead.org; Fri, 11 Mar 2011 05:43:02 +0000
Date: Fri, 11 Mar 2011 14:29:22 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: [PATCH] makedumpfile: Copy correct nr_cpus info to dumpfile
	during re-filtering
Message-Id: <20110311142922.b60b80e7.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <20110309121506.13403.73845.stgit@mars.in.ibm.com>
References: <20110309121506.13403.73845.stgit@mars.in.ibm.com>
Mime-Version: 1.0
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
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: Dave Anderson <anderson@redhat.com>, kexec@lists.infradead.org


Hi Mahesh,

Nice catching!
Your patch has been merged to mainline:
http://makedumpfile.git.sourceforge.net/git/gitweb.cgi?p=makedumpfile/makedumpfile;a=summary

Thank you very much.


Thanks
Ken'ichi Ohmichi

On Wed, 09 Mar 2011 17:45:48 +0530
Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
>
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> During re-filtering nr_cpus is to 0 in the o/p dumpfile and hence crash
> utility fails to open the re-filtered dumpfile.
> 
> This patch fixes this issue by copying nr_cpus info from kdump-compressed
> dumpfile to info->nr_cpus which then get's correctly copied to o/p
> dumpfile.
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> ---
> 
>  makedumpfile.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index a0fad6a..7d0c663 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -924,6 +924,7 @@ get_kdump_compressed_header_info(char *filename)
>  		goto error;
>  	}
>  	memcpy(info->kh_memory, &kh, sizeof(kh));
> +	info->nr_cpus = dh.nr_cpus;
>  
>  	if (dh.header_version >= 3) {
>  		/* A dumpfile contains vmcoreinfo data. */
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
