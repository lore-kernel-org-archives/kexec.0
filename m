From: Mimi Zohar <zohar@linux.ibm.com>
Date: Sun, 13 Feb 2022 15:27:54 -0500
Subject: [PATCH v5 0/6] KEXEC_SIG with appended signature
In-Reply-To: <cover.1641900831.git.msuchanek@suse.de>
References: <cover.1641900831.git.msuchanek@suse.de>
Message-ID: <c769b62e02e48e2eb2d50de9db90773f5f0acb5f.camel@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

[Cc'ing  Nageswara R Sastry]

Hi Michal,

On Tue, 2022-01-11 at 12:37 +0100, Michal Suchanek wrote:
> Hello,
> 
> This is a refresh of the KEXEC_SIG series.
> 
> This adds KEXEC_SIG support on powerpc and deduplicates the code dealing
> with appended signatures in the kernel.

tools/testing/selftests/kexec/test_kexec_file_load.sh probably needs to
be updated to reflect the new Kconfig support.

FYI, commit 65e38e32a959 ("selftests/kexec: Enable secureboot tests for
PowerPC") recently was upstreamed.

-- 
thanks,

Mimi


