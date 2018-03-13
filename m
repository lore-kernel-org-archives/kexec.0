Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1evnlA-0002I4-MI
 for kexec@lists.infradead.org; Tue, 13 Mar 2018 17:30:53 +0000
Subject: Re: [PATCH v4 4/5] kexec: add option to fall back to KEXEC_LOAD when
 KEXEC_FILE_LOAD is not supported.
References: <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1520342150.git.msuchanek@suse.de>
 <19a47e290fc03efea82af845740ae8f6b30f13b8.1520342150.git.msuchanek@suse.de>
From: Tony Jones <tonyj@suse.de>
Message-ID: <b7fcd583-d7d2-1348-5a17-7294c9f19e9a@suse.de>
Date: Tue, 13 Mar 2018 10:30:28 -0700
MIME-Version: 1.0
In-Reply-To: <19a47e290fc03efea82af845740ae8f6b30f13b8.1520342150.git.msuchanek@suse.de>
Content-Language: en-US
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
To: kexec@lists.infradead.org
Cc: msuchanek@suse.de, Simon Horman <horms@verge.net.au>, dyoung@redhat.com, Petr Tesarik <ptesarik@suse.cz>

On 03/06/2018 05:15 AM, Michal Suchanek wrote:
> Not all architectures implement KEXEC_FILE_LOAD. However, on some
> archiectures KEXEC_FILE_LOAD is required when secure boot is enabled in
> locked-down mode. Previously users had to select the KEXEC_FILE_LOAD
> syscall with undocumented -s option. However, if they did pass the
> option kexec would fail on architectures that do not support it.
> 
> So add an -a option that tries KEXEC_FILE_LOAD and when it is not
> supported tries KEXEC_LOAD.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

David, Simon.

Is there any feedback on v4 of this patchset?  Adding a new option for fallback rather than changing the existing behavior was the v3 feedback on March 2nd.

Cheers!

Tony

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
