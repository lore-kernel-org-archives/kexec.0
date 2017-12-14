Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by casper.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1ePQhz-00085Q-NX
 for kexec@lists.infradead.org; Thu, 14 Dec 2017 10:25:45 +0000
Date: Thu, 14 Dec 2017 18:25:13 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] certs: always use secondary keyring first if possible
Message-ID: <20171214102513.GA2371@dhcp-128-65.nay.redhat.com>
References: <20171118044711.GA7352@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20171118044711.GA7352@dhcp-128-65.nay.redhat.com>
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
To: David Howells <dhowells@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On 11/18/17 at 12:47pm, Dave Young wrote:
> Commit d3bfe84129f6 introduced secondary_trusted_keys keyring, current
> users of verify_pkcs7_signature are below:
> net/wireless/reg.c : uses its own trusted_keys
> kernel/module_signing.c : pass NULL trusted_keys 
> crypto/asymmetric_keys/verify_pefile.c : pass NULL trusted_keys
> 
> For both module and pefile verification, there is no reason to use builtin
> keys only. Actually in Fedora kernel module signing code passes 1UL, but
> kexec code does not pass 1UL for pefile verification thus we have below bug
> https://bugzilla.redhat.com/show_bug.cgi?id=1470995
> 
> Drop the hard code 1UL checking so that pefile verification can use
> secondary keyring as well.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  certs/system_keyring.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> --- linux-x86.orig/certs/system_keyring.c
> +++ linux-x86/certs/system_keyring.c
> @@ -229,8 +229,6 @@ int verify_pkcs7_signature(const void *d
>  		goto error;
>  
>  	if (!trusted_keys) {
> -		trusted_keys = builtin_trusted_keys;
> -	} else if (trusted_keys == (void *)1UL) {
>  #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
>  		trusted_keys = secondary_trusted_keys;
>  #else

Another ping.

If the (-1UL) is really needed, below file need update to use it
But I think it is ugly..
crypto/asymmetric_keys/verify_pefile.c

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
