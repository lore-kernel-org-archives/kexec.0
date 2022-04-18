From: Eric DeVolder <eric.devolder@oracle.com>
Date: Mon, 18 Apr 2022 17:03:39 -0500
Subject: [PATCH v7 2/8] x86/crash: Introduce new options to support cpu
 and memory hotplug
In-Reply-To: <Ylgot+LUDQl+G/5N@zn.tnic>
References: <20220413164237.20845-1-eric.devolder@oracle.com>
 <20220413164237.20845-3-eric.devolder@oracle.com> <Ylgot+LUDQl+G/5N@zn.tnic>
Message-ID: <f3ea7ee0-1cb8-6928-d0af-4c2fc63a42a4@oracle.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Boris,
Thanks for looking! I've inline comments below.
Eric

On 4/14/22 08:59, Borislav Petkov wrote:
> On Wed, Apr 13, 2022 at 12:42:31PM -0400, Eric DeVolder wrote:
>> CRASH_HOTPLUG is to enable cpu and memory hotplug support of crash.
> 
> What for?
Fair point, a new define isn't necessarily needed. I've now eliminated
CONFIG_CRASH_HOTPLUG and am using CONFIG_HOTPLUG_CPU || CONFIG_MEMORY_HOTPLUG
instead.

> 
> Why don't you put all that new code you're adding under an
> MEMORY_HOTPLUG ifdef? It seems you would need to do that when memory
> hotplug is enabled, anyway.
I think I have done that, in patch "crash: add generic infrastructure for crash
hotplug support", I do have code under MEMORY_HOTPLUG as well as HOTPLUG_CPU.
But...

> 
> Also, looking further into your patchset, you have ugly ifdeffery.
> Instead of that, pls add stubs for the !MEMORY_HOTPLUG case so that
> everything is abstracted away in the headers.

I've examined the code with this thought in mind, and I'm not exactly sure how
this code should be restructured for !HOTPLUG stubs. I'd very much appreciate
an example in order to facilitate accommodating the request!

Thanks!
eric

> 
> Thx.
> 

