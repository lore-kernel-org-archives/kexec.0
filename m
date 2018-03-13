Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1evqmI-0005ZP-OF
 for kexec@lists.infradead.org; Tue, 13 Mar 2018 20:44:12 +0000
Date: Tue, 13 Mar 2018 21:43:54 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Subject: Re: [PATCH 4/5] kexec: fallback to KEXEC_LOAD when KEXEC_FILE_LOAD
 is not supported.
Message-ID: <20180313214354.21e75416@naga.suse.cz>
In-Reply-To: <20180302124458.md6hyibep32b3zom@verge.net.au>
References: <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1519646210.git.msuchanek@suse.de>
 <ebc4bc6f1dc7d62ba5c81f40c7f7d83a8ae3eb5d.1519646210.git.msuchanek@suse.de>
 <20180302124458.md6hyibep32b3zom@verge.net.au>
MIME-Version: 1.0
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
To: Simon Horman <horms@verge.net.au>
Cc: Petr Tesarik <ptesarik@suse.cz>, kexec@lists.infradead.org, Tony Jones <tonyj@suse.com>

On Fri, 2 Mar 2018 13:44:58 +0100
Simon Horman <horms@verge.net.au> wrote:

> On Mon, Feb 26, 2018 at 01:00:37PM +0100, Michal Suchanek wrote:
> > Not all architectures implement KEXEC_FILE_LOAD. However, on some
> > archiectures KEXEC_FILE_LOAD is required when secure boot is
> > enabled in locked-down mode. Previously users had to select the
> > KEXEC_FILE_LOAD syscall with undocumented -s option. However, if
> > they did pass the option kexec would fail on architectures that do
> > not support it.
> > 
> > When no option is passed to select one syscall or the other try
> > KEXEC_FILE_LOAD and fall back to KEXEC_LOAD when not suported.  
> 
> Has there been a release of kexec-tools with things arranged they
> way they currently are?

$ git tag --contains
046d1755d2bd723a11a180c265e61a884990712e 
v2.0.10
v2.0.10-rc1
v2.0.11
v2.0.11-rc1
v2.0.12
v2.0.12-rc1
v2.0.13
v2.0.13-rc1
v2.0.14
v2.0.14-rc1
v2.0.15
v2.0.15-rc1
v2.0.16-rc1
v2.0.8
v2.0.8-rc1
v2.0.9
v2.0.9-rc1

> 
> Can we document this behaviour and the related undocumented options?

It's done in a followup patch.

Thanks

Michal


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
