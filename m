Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1429290437.5479.13.camel@infradead.org>
Subject: Re: [PATCH RFC 5/6] arm64: Add support for binary image
From: Geoff Levand <geoff@infradead.org>
Date: Fri, 17 Apr 2015 10:07:17 -0700
In-Reply-To: <0a15f2079e6c378996dceda1d509df77d2f43899.1429201849.git.panand@redhat.com>
References: <cover.1429201849.git.panand@redhat.com>
 <0a15f2079e6c378996dceda1d509df77d2f43899.1429201849.git.panand@redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Pratyush Anand <panand@redhat.com>
Cc: kexec@lists.infradead.org, kexec@lists.fedoraproject.org

On Thu, 2015-04-16 at 22:17 +0530, Pratyush Anand wrote:
> This patch adds support to use binary image ie arch/arm64/boot/Image.
> 
> Binary image does not have sufficient knowledge to extract page offset
> information, which is needed by kexec tool. Use a new command parameter
> --page-offset, so that user can provide page offset information for
> liner mapping.

This looks OK.  I'll add it to my arm64 series.

> diff --git a/kexec/arch/arm64/kexec-arm64.h b/kexec/arch/arm64/kexec-arm64.h
> index 61e15032cbd6..7e4d0568bd01 100644
> --- a/kexec/arch/arm64/kexec-arm64.h
> +++ b/kexec/arch/arm64/kexec-arm64.h
> @@ -17,6 +17,8 @@
>  #define BOOT_BLOCK_LAST_COMP_VERSION 16
>  #define COMMAND_LINE_SIZE 512
>  
> +#define ARM64_DEFAULT_PAGE_OFFSET 0xfffffe0000000000
> +

Since this is only used in kexec-image-arm64.c, I'll move it there.

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
