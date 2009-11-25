Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NDQjG-0003cc-Qb
	for kexec@lists.infradead.org; Wed, 25 Nov 2009 22:52:59 +0000
Date: Thu, 26 Nov 2009 09:52:52 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: Architecture detection code
Message-ID: <20091125225250.GK4794@verge.net.au>
References: <1258738692-4990-1-git-send-email-mat@brain-dump.org>
	<aec7e5c30911242113y7706e9c0u2262cdd7ab8bf38d@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aec7e5c30911242113y7706e9c0u2262cdd7ab8bf38d@mail.gmail.com>
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
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Andrea Adami <andrea.adami@gmail.com>, kexec@lists.infradead.org, Marc Andre Tanner <mat@brain-dump.org>

On Wed, Nov 25, 2009 at 02:13:56PM +0900, Magnus Damm wrote:
> On Sat, Nov 21, 2009 at 2:38 AM, Marc Andre Tanner <mat@brain-dump.org> wrote:
> > I recently had the same problem as Magnus and came up with the
> > following patch. It changes the architecture detection code to
> > also accept partiall matches. Which means and "arm" entry in
> > arch_map_entry will work for all arm* versions.
> >
> > Please consider applying this patch and reverting the two from
> > Magnus.
> 
> Sure, I'm happy to see that the arm supports gets more attention! =)

Hi,

I'd like to apply the following patch. Let me know if I've botched things.

--------------------------------------------------------------------------

arm: fix architecture detection

There are many variants of arm and it seems to be impractical to
add them all to the arches array. Instead just match on the
leading "arm" portion of the utsname.

I have made this specific to arm for now, as I'm not sure what
fallout might occur if it was made more generic. e.g. arch ppc
matching utsname ppc64 is a concern.

Based on variants of this patch submitted by Andrea Adami and
Marc Andre Tanner, and feedback from Magnus Damm.

Cc: Andrea Adami <andrea.adami@gmail.com>
Cc: Marc Andre Tanner <mat@brain-dump.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 kexec/arch/arm/kexec-arm.c |    2 --
 kexec/phys_arch.c          |    7 ++++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/arm/kexec-arm.c b/kexec/arch/arm/kexec-arm.c
index 3fdf839..4b4a659 100644
--- a/kexec/arch/arm/kexec-arm.c
+++ b/kexec/arch/arm/kexec-arm.c
@@ -113,8 +113,6 @@ int arch_process_options(int argc, char **argv)
 
 const struct arch_map_entry arches[] = {
 	{ "arm", KEXEC_ARCH_ARM },
-	{ "armv6l", KEXEC_ARCH_ARM },
-	{ "armv7l", KEXEC_ARCH_ARM },
 	{ 0 },
 };
 
diff --git a/kexec/phys_arch.c b/kexec/phys_arch.c
index ff8c28b..1571a0f 100644
--- a/kexec/phys_arch.c
+++ b/kexec/phys_arch.c
@@ -13,9 +13,14 @@ long physical_arch(void)
 		return -1;
 	}
 
-	for (i = 0; arches[i].machine; ++i)
+	for (i = 0; arches[i].machine; ++i) {
 		if (strcmp(utsname.machine, arches[i].machine) == 0)
 			return arches[i].arch;
+		if ((strcmp(arches[i].machine, "arm") == 0) &&
+		    (strncmp(utsname.machine, arches[i].machine,
+		     strlen(arches[i].machine)) == 0))
+			return arches[i].arch;
+	}
 
 	fprintf(stderr, "Unsupported machine type: %s\n",
 		utsname.machine);
-- 
1.6.5.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
