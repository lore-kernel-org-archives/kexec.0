Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TaV3U-000361-85
 for kexec@lists.infradead.org; Mon, 19 Nov 2012 17:22:44 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <878v9zp55t.fsf@xmission.com>
 <1353294278-32230-1-git-send-email-yinghai@kernel.org>
 <1353294278-32230-5-git-send-email-yinghai@kernel.org>
Date: Mon, 19 Nov 2012 09:22:29 -0800
In-Reply-To: <1353294278-32230-5-git-send-email-yinghai@kernel.org> (Yinghai
 Lu's message of "Sun, 18 Nov 2012 19:04:36 -0800")
Message-ID: <87haol33u2.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/6] kexec,
 x86: set ext_cmd_line_ptr when boot_param is put high
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
To: Yinghai Lu <yinghai@kernel.org>
Cc: Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>

Yinghai Lu <yinghai@kernel.org> writes:

> only do that for bzImage64, and it could have command line above 4g.

Just a small nit.
>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
>  kexec/arch/i386/x86-linux-setup.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
>
> diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
> index b0e6119..c929166 100644
> --- a/kexec/arch/i386/x86-linux-setup.c
> +++ b/kexec/arch/i386/x86-linux-setup.c
> @@ -105,7 +105,13 @@ void setup_linux_bootloader_parameters(
>  		/* setup_move_size */
>  	/* } */
>  	if (real_mode->protocol_version >= 0x0202) {
> -		real_mode->cmd_line_ptr = real_mode_base + cmdline_offset;
> +		unsigned long cmd_line_ptr = real_mode_base + cmdline_offset;
> +
> +		real_mode->cmd_line_ptr = cmd_line_ptr & 0xffffffff;
> +		if (real_mode->protocol_version >= 0x020c)

It probably makes sense to guard this with a test to see if the
cmd_line_ptr value exceeds 4G before doing the >> 32 in case a 32bit
kernel uses boot protocol 0x020c and we have a 32bit kexec.

+		if ((real_mode->protocol_version >= 0x020c) &&
+		    ((cmd_line_ptr & 0xffffffffUL) != cmd_line_ptr))
		
> +			real_mode->ext_cmd_line_ptr = cmd_line_ptr >> 32;
> +
> +		printf("cmd_line_ptr: %lx\n", cmd_line_ptr);
>  	}
>  
>  	/* Fill in the command line */

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
