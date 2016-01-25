Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from helcar.hengli.com.au ([209.40.204.226])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aNhhy-0004ri-2z
 for kexec@lists.infradead.org; Mon, 25 Jan 2016 14:01:32 +0000
Date: Mon, 25 Jan 2016 22:00:58 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] Don't require SpcSpOpusInfo in Authenticode pkcs7
 signatures
Message-ID: <20160125140058.GA8379@gondor.apana.org.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160119010844.GA2919@dhcp-128-65.nay.redhat.com>
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
Cc: kexec@lists.infradead.org, xlpang@redhat.com, linux-kernel@vger.kernel.org, dhowells@redhat.com, pjones@redhat.com, linux-crypto@vger.kernel.org, vgoyal@redhat.com

Dave Young <dyoung@redhat.com> wrote:
>
>> So anyway, we should not be checking this field for presence or any
>> particular value: if the field exists, it should be at the right place,
>> but aside from that, as long as the hash matches the field is good.
>> 
>> Signed-off-by: Peter Jones <pjones@redhat.com>
>
> Tested-by: Dave Young <dyoung@redhat.com>

Patch applied.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
