From: Dave Hansen <dave.hansen@intel.com>
Date: Wed, 23 Feb 2022 09:45:12 -0800
Subject: [PATCH v5 00/12] x86: Trenchboot secure dynamic launch Linux
 kernel support
In-Reply-To: <1645070085-14255-1-git-send-email-ross.philipson@oracle.com>
References: <1645070085-14255-1-git-send-email-ross.philipson@oracle.com>
Message-ID: <04080c88-3e69-b4e6-0af2-0690accaa02f@intel.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 2/16/22 19:54, Ross Philipson wrote:
> The larger focus of the TrenchBoot project (https://github.com/TrenchBoot) is to
> enhance the boot security and integrity in a unified manner. The first area of
> focus has been on the Trusted Computing Group's Dynamic Launch for establishing
> a hardware Root of Trust for Measurement, also know as DRTM (Dynamic Root of
> Trust for Measurement). The project has been and continues to work on providing
> a unified means to Dynamic Launch that is a cross-platform (Intel and AMD) and
> cross-architecture (x86 and Arm), with our recent involvment in the upcoming
> Arm DRTM specification. The order of introducing DRTM to the Linux kernel
> follows the maturity of DRTM in the architectures. Intel's Trusted eXecution
> Technology (TXT) is present today and only requires a preamble loader, e.g. a
> boot loader, and an OS kernel that is TXT-aware. AMD DRTM implementation has
> been present since the introduction of AMD-V but requires an additional
> component that is AMD specific and referred to in the specification as the
> Secure Loader, which the TrenchBoot project has an active prototype in
> development. Finally Arm's implementation is in specification development stage
> and the project is looking to support it when it becomes available.

What problem is this patch series solving?  Is the same problem solved
in a different way in the kernel today?  What is wrong with that
solution?  What effects will end users see if they apply this series?

