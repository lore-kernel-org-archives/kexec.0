Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH 0/2] kexec-tools: arm64: Add dcache enabling facility
References: <cover.1479788404.git.panand@redhat.com>
From: Geoff Levand <geoff@infradead.org>
Message-ID: <8415f028-f42e-2980-9b60-e85aae046d02@infradead.org>
Date: Tue, 22 Nov 2016 10:56:59 -0800
MIME-Version: 1.0
In-Reply-To: <cover.1479788404.git.panand@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Pratyush Anand <panand@redhat.com>, kexec@lists.infradead.org
Cc: james.morse@arm.com, linux-arm-kernel@lists.infradead.org

Hi Pratyush,

On 11/21/2016 08:32 PM, Pratyush Anand wrote:
> It takes more that 2 minutes to verify SHA in purgatory when vmlinuz image
> is around 13MB and initramfs is around 30MB. It takes more than 20 second
> even when we have -O2 optimization enabled. However, if dcache is enabled
> during purgatory execution then, it takes just a second in SHA verification.

As I had mentioned in another thread, I think -O2 optimization is
sufficient considering the complexity of the code needed to enable
the dcache.  Integrity checking is only needed for crash dump
support.  If the crash reboot takes an extra 20 seconds does it
matter?

For the re-boot of a stable system where the new kernel is loaded
then immediately kexec'ed into integrity checking is not needed.
For that arm64 support needs to be added to kexec-lite.

-Geoff

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
