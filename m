Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlGMM-0006zL-Vu
 for kexec@lists.infradead.org; Tue, 16 Jun 2020 18:31:00 +0000
Received: by mail-pl1-x635.google.com with SMTP id j4so5508727plk.3
 for <kexec@lists.infradead.org>; Tue, 16 Jun 2020 11:30:58 -0700 (PDT)
Date: Tue, 16 Jun 2020 11:30:56 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH][next] kexec_file: Use array_size() helper in memcpy()
Message-ID: <202006161130.EC036806@keescook>
References: <20200616182041.GA30841@embeddedor>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200616182041.GA30841@embeddedor>
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
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>, linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 01:20:41PM -0500, Gustavo A. R. Silva wrote:
> Use array_size() instead of the open-coded version in memcpy(). These
> sorts of multiplication factors need to be wrapped in array_size().
> 
> Also, while there, use the preferred form for passing a size of a struct.
> The alternative form where struct name is spelled out hurts readability
> and introduces an opportunity for a bug when the pointer variable type is
> changed but the corresponding sizeof that is passed as argument is not.
> 
> This issue was found with the help of Coccinelle and, audited and fixed
> manually.
> 
> Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
