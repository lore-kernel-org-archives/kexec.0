From: Borislav Petkov <bp@alien8.de>
Date: Thu, 14 Apr 2022 15:59:19 +0200
Subject: [PATCH v7 2/8] x86/crash: Introduce new options to support cpu
 and memory hotplug
In-Reply-To: <20220413164237.20845-3-eric.devolder@oracle.com>
References: <20220413164237.20845-1-eric.devolder@oracle.com>
 <20220413164237.20845-3-eric.devolder@oracle.com>
Message-ID: <Ylgot+LUDQl+G/5N@zn.tnic>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Wed, Apr 13, 2022 at 12:42:31PM -0400, Eric DeVolder wrote:
> CRASH_HOTPLUG is to enable cpu and memory hotplug support of crash.

What for?

Why don't you put all that new code you're adding under an
MEMORY_HOTPLUG ifdef? It seems you would need to do that when memory
hotplug is enabled, anyway.

Also, looking further into your patchset, you have ugly ifdeffery.
Instead of that, pls add stubs for the !MEMORY_HOTPLUG case so that
everything is abstracted away in the headers.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

