Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.tuxforce.de ([84.38.66.179])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZJgI-00DB6D-Da
 for kexec@lists.infradead.org; Wed, 21 Apr 2021 20:42:43 +0000
Subject: Re: [PATCH 2/2] fs/kernel_read_file: use
 usermodehelper_read_trylock() as a stop gap
References: <20210416235850.23690-1-mcgrof@kernel.org>
 <20210416235850.23690-3-mcgrof@kernel.org>
From: Lukas Middendorf <kernel@tuxforce.de>
Message-ID: <35ff02c7-8a76-730e-ddb9-f91634f5098b@tuxforce.de>
Date: Wed, 21 Apr 2021 22:42:36 +0200
MIME-Version: 1.0
In-Reply-To: <20210416235850.23690-3-mcgrof@kernel.org>
Content-Language: en-US
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
To: Luis Chamberlain <mcgrof@kernel.org>, rafael@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, jack@suse.cz, bvanassche@acm.org, jeyu@kernel.org, ebiederm@xmission.com
Cc: mchehab@kernel.org, keescook@chromium.org, linux-fsdevel@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Lukas Middendorf <kernel@tuxforce.de>


On 17/04/2021 01:58, Luis Chamberlain wrote:
> The VFS lacks support to do automatic freeze / thaw of filesystems
> on the suspend / resume cycle. This can cause some issues, namely
> stalls when we have reads/writes during the suspend / resume cycle.
> 
> Although for module loading / kexec the probability of this happening
> is extremely low, maybe even impossible, its a known real issue with
> the request_firmare() API which it does direct fs read. For this reason
> only be chatty about the issue on the call used by the firmware API.
> 
> Lukas Middendorf has reported an easy situation to reproduce, which can
> be caused by questionably buggy drivers which call the request_firmware()
> API on resume.
> 
[snip]
> 
> The VFS fs freeze work fixes this issue, however it requires a bit
> more work, which may take a while to land upstream, and so for now
> this provides a simple stop-gap solution.
> 
> We can remove this stop-gap solution once the kernel gets VFS
> fs freeze / thaw support.
> 
> Reported-by: Lukas Middendorf <kernel@tuxforce.de>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Tested-by: Lukas Middendorf <kernel@tuxforce.de>


Works as advertised.

This prevents stalls on resume with buggy drivers (e.g. si2168) by 
totally blocking uncached request_firmware() on resume. Uncached 
request_firmware() will fail reliably (also in situations where it by 
accident worked previously without stalling).
If firmware caching has been set up properly before suspend (either 
through firmware_request_cache() or through request_firmware() outside 
of a suspend/resume situation), the call to request_firmware() will 
still work as expected on resume. This should not break properly 
behaving drivers.

A failing firmware load is definitely preferable (and easier to debug 
and fix in the respective drivers) compared to a stall on resume.

Lukas

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
