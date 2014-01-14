Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W2rpw-0001vz-CK
 for kexec@lists.infradead.org; Tue, 14 Jan 2014 00:26:33 +0000
Date: Tue, 14 Jan 2014 09:26:05 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [RESEND PATCH] kexec: arm: Fix endianness in crashdump header
Message-ID: <20140114002605.GA18217@verge.net.au>
References: <1389610045-5372-1-git-send-email-kondratyuk.taras@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1389610045-5372-1-git-send-email-kondratyuk.taras@gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Taras Kondratyuk <taras.kondratiuk@linaro.org>
Cc: kexec@lists.infradead.org, patches@linaro.org

On Mon, Jan 13, 2014 at 12:47:25PM +0200, Taras Kondratyuk wrote:
> From: Taras Kondratiuk <taras.kondratiuk@linaro.org>
> 
> Currently little-endian ELFDATA is hard-coded in crashdump header.
> This lead to a wrong header format if crashdump is generated on BE system.
> 
> Set native endianness into ELFDATA field.
> 
> Signed-off-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
