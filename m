Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v9 02/11] kexec_file: make
 kexec_image_post_load_cleanup_default() global
References: <20180425062629.29404-1-takahiro.akashi@linaro.org>
 <20180425062629.29404-3-takahiro.akashi@linaro.org>
From: James Morse <james.morse@arm.com>
Message-ID: <cbf66675-1671-32f9-1410-a76986becf85@arm.com>
Date: Tue, 1 May 2018 18:46:04 +0100
MIME-Version: 1.0
In-Reply-To: <20180425062629.29404-3-takahiro.akashi@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: herbert@gondor.apana.org.au, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, bhsharma@redhat.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, dhowells@redhat.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, dyoung@redhat.com, davem@davemloft.net, vgoyal@redhat.com

Hi Akashi,

On 25/04/18 07:26, AKASHI Takahiro wrote:
> Change this function from static to global so that arm64 can implement
> its own arch_kimage_file_post_load_cleanup() later using
> kexec_image_post_load_cleanup_default().

Do we need to call kexec_image_post_load_cleanup_default()? All it does is call
the image-type fops->cleanup(), which you don't implement in this series.

Is this just-in-case someone adds cleanup() later and is surprised only the
arch-level helper is called?


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
