Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH] kernel: add panic_on_taint
References: <20200506222815.274570-1-aquini@redhat.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <60e5c03f-ab34-8095-e2f3-e0ee6a1fb9c1@infradead.org>
Date: Wed, 6 May 2020 17:20:16 -0700
MIME-Version: 1.0
In-Reply-To: <20200506222815.274570-1-aquini@redhat.com>
Content-Language: en-US
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
To: Rafael Aquini <aquini@redhat.com>, linux-kernel@vger.kernel.org
Cc: keescook@chromium.org, bhe@redhat.com, corbet@lwn.net, linux-doc@vger.kernel.org, kexec@lists.infradead.org, mcgrof@kernel.org, cai@lca.pw, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, dyoung@redhat.com

On 5/6/20 3:28 PM, Rafael Aquini wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 7bc83f3d9bdf..75c02c1841b2 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3404,6 +3404,9 @@
>  	panic_on_warn	panic() instead of WARN().  Useful to cause kdump
>  			on a WARN().
>  
> +	panic_on_taint	panic() when the kernel gets tainted, if the taint
> +			flag being set matches with the assigned bitmask.
> +

Where is the bitmask assigned?

I.e., maybe this text should be more like:

	panic_on_taint=<bitmask>
and then the bits are explained.  See e.g. panic= and panic_print=
in this same file.


>  	crash_kexec_post_notifiers
>  			Run kdump after running panic-notifiers and dumping
>  			kmsg. This only for the users who doubt kdump always


-- 
~Randy


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
