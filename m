From: Simon Horman <horms@kernel.org>
Date: Fri, 29 Apr 2022 11:58:56 +0200
Subject: [PATCH] arm64/crashdump-arm64: increase CRASH_MAX_MEMORY_RANGES
 to 32k
In-Reply-To: <Ymc5VxBOQgyrrN+y@MiWiFi-R3L-srv>
References: <20220419172327.11288-1-abuehaze@amazon.com>
 <Ymc5VxBOQgyrrN+y@MiWiFi-R3L-srv>
Message-ID: <Ymu24KkCD1UHzGmI@vergenet.net>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Tue, Apr 26, 2022 at 08:14:15AM +0800, Baoquan He wrote:
> On 04/19/22 at 05:23pm, abuehaze14 wrote:
> > On ARM64 based VMs hotplugging more than 31GB of memory will cause
> > kdump to fail loading as it's hitting the CRASH_MAX_MEMORY_RANGES
> > limit which is currently 32 on ARM64 given that the  memory block size
> > is 1GB. This patch is raising CRASH_MAX_MEMORY_RANGES
> > to 32K similar to what we have on x86, this should allow
> > kdump to work until the VM has 32TB which should be
> > enough for a long time.
> > 
> > Signed-off-by: Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>
> 
> Sounds reasonable.
> 
> Acked-by: Baoquan He <bhe@redhat.com>
> 
> By the way, Simon usually collects kexec-tools patches every one to two
> weeks, no need to always ping in a short time.

Thanks and sorry for the delay.

I have applied this patch to main.

