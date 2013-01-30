Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U0fJB-0006zP-7B
 for kexec@lists.infradead.org; Wed, 30 Jan 2013 21:35:05 +0000
Message-ID: <510991F3.9020006@zytor.com>
Date: Wed, 30 Jan 2013 13:34:43 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH v8 3/7] kexec, x86: clean boot_params area for entry-32bit
 path
References: <1359581120-24397-1-git-send-email-yinghai@kernel.org>
 <1359581120-24397-4-git-send-email-yinghai@kernel.org>
In-Reply-To: <1359581120-24397-4-git-send-email-yinghai@kernel.org>
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
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

On 01/30/2013 01:25 PM, Yinghai Lu wrote:
>  
> +static void clean_boot_params(unsigned char *real_mode, unsigned long size)
> +{
> +	unsigned long end;
> +
> +	/* clear value before header */
> +	memset(real_mode, 0, 0x1f1);
> +	/* clear value after setup_header  */
> +	end = *(real_mode + 0x201);

real_mode[0x201] might be clearer...

> +	end += 0x202;
> +	if (end < size)
> +		memset(real_mode + end, 0, size - end);
> +}

You don't actually need the test... the value is inherently smaller than
0x301 which is less than the size.

That being said, if you want to sanity-check it you can check that the
value is in a sensible range -- the permitted range is 0x22 to 0x7f
inclusive, corresponding to a total end value of 0x224 to 0x281.

	-hpa


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
