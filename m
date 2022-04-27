From: Borislav Petkov <bp@alien8.de>
Date: Wed, 27 Apr 2022 12:48:09 +0200
Subject: [PATCH v7 2/8] x86/crash: Introduce new options to support cpu
 and memory hotplug
In-Reply-To: <0aee5cd1-eb8c-f778-c6e5-7f5ca3624d15@oracle.com>
References: <20220413164237.20845-1-eric.devolder@oracle.com>
 <20220413164237.20845-3-eric.devolder@oracle.com>
 <Ylgot+LUDQl+G/5N@zn.tnic>
 <f3ea7ee0-1cb8-6928-d0af-4c2fc63a42a4@oracle.com>
 <Yl6PueNCZZeobMWr@zn.tnic>
 <cc7a6b5c-954c-54fe-be5f-324dc984ac51@oracle.com>
 <Ymb1tBJsch/TB2ph@zn.tnic>
 <0aee5cd1-eb8c-f778-c6e5-7f5ca3624d15@oracle.com>
Message-ID: <YmkfaSAiGIYgTlvY@zn.tnic>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Tue, Apr 26, 2022 at 03:08:26PM -0500, Eric DeVolder wrote:
> Why is it safe to examine kexec_crash_image outside the mutex? As I
> understand it, there is still the (very rare) opportunity for a kdump
> load/unload initiated via userland and this check to collide. (Similarly, I
> believe the mutex entry is almost always assured/likely.)

Yeah, I guess. As the comment in do_kexec_load() says

	"KISS: always take the mutex."

so ignore this part of the diff and let's always grab the mutex.

Sorry for the confusion.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

