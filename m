Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XlJRx-0005tz-Mx
 for kexec@lists.infradead.org; Mon, 03 Nov 2014 15:21:46 +0000
Date: Mon, 3 Nov 2014 10:21:16 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v6] kernel, add panic_on_warn
Message-ID: <20141103152116.GB22503@redhat.com>
References: <1415025143-4345-1-git-send-email-prarit@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1415025143-4345-1-git-send-email-prarit@redhat.com>
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
To: Prarit Bhargava <prarit@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>, hedi@sgi.com, Jonathan Corbet <corbet@lwn.net>, jbaron@akamai.com, kexec@lists.infradead.org, Rusty Russell <rusty@rustcorp.com.au>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Fabian Frederick <fabf@skynet.be>, isimatu.yasuaki@jp.fujitsu.com, "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, linux-api@vger.kernel.org

On Mon, Nov 03, 2014 at 09:32:23AM -0500, Prarit Bhargava wrote:

[..]
> +
> +static int __init panic_on_warn_setup(char *s)
> +{
> +	/* Enabling this on a kdump kernel could cause a bogus panic. */
> +	if (!is_kdump_kernel())
> +		panic_on_warn = 1;

I think it would be better if we leave it to user space to remove
panic_on_warn from command line of second kernel.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
