Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F1ECD8CA4
	for <kexec@archiver.kernel.org>; Tue,  9 Jun 2026 14:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PjHIRpjtlXIyylASoF8WIzC6zkAZuxm/NxysGVUExR4=; b=A60/Af7nJBjyXVvP43nqRNGOzp
	gtmkZBCMQ+wWU48VE+O0QcGLL1QhFKqoZdULZm0DgAEJZHM44ZOHjbI6NKXJ8hfqU2zggSCuWA3W2
	1Tcj2dmzUzC5mCVlUnq00BcpT/l2Urekcp0lNaGzU9MQbUZ+kZq/tQZj+eao5Op0oo5MO2e1eeKd1
	vEvGRWQ4P2JfJLz+fi3MDhaEF+NIZI2za1AemFQogx4PAwO+T/HefeqtvnA97lhGAesMCOjyU4zEz
	DG1CBUK+nBPh8y3148avTTGaWHjVPeBWc/0BoXo7efUkX/yFpLo+zGErggtA636JdqSiw4CFf9pre
	fJ5zExDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWxRC-00000005leM-26s8;
	Tue, 09 Jun 2026 14:28:18 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWxRB-00000005le7-00Hj
	for kexec@lists.infradead.org;
	Tue, 09 Jun 2026 14:28:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6938940454;
	Tue,  9 Jun 2026 14:28:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4641F00898;
	Tue,  9 Jun 2026 14:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781015296;
	bh=PjHIRpjtlXIyylASoF8WIzC6zkAZuxm/NxysGVUExR4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=XjnfkonvBA7BPNQ+bKKY6oIc51fRqT6F7xQ5JkGtkh/+n3vxfPebE28AtnI121Tz2
	 VY5M28uj9LWKoQr/N+8GKcqeMxutY2VcXRe+22FgmwDZiv4EAI2xGaDAukkgr6aIkl
	 GZw2xTY619ykBheB5bPqXoEU+eRmKSJ3j/Pb0eMgaacWWtVljP7Djn42kDX3tlOANd
	 oeWIJzCmqgwa4HLNDgS8Gzfmd5E66hbCgIYGHiqh2YC72J810QRKJJrBp4WyFR5CsV
	 +JJQzoYVTrUwNt/1MaLPyCIaWdQEC0rK/onYbEg6TXottOQSyUkdmarinDxoUVsTEz
	 h/Iy4rexr7Ydw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Mike Rapoport <rppt@kernel.org>,  linux-kselftest@vger.kernel.org,
	shuah@kernel.org,  akpm@linux-foundation.org,  linux-mm@kvack.org,
	skhan@linuxfoundation.org,  linux-doc@vger.kernel.org,
	jasonmiu@google.com,  linux-kernel@vger.kernel.org,  corbet@lwn.net,
	ran.xiaokai@zte.com.cn,  kexec@lists.infradead.org,
	pratyush@kernel.org,  graf@amazon.com,
	Logan Odell <loganodell@google.com>
Subject: Re: [RFC v1 0/9] kho: granular compatibility and header decoupling
In-Reply-To: <aibYJvzQQnpoN6YW@plex> (Pasha Tatashin's message of "Mon, 8 Jun
	2026 16:12:56 +0000")
References: <20260605033235.717351-1-pasha.tatashin@soleen.com>
	<178083348872.1648214.17778188633648887952.b4-review@b4>
	<aiVp5RlbWRz5VnPB@plex>
	<178091437240.1648214.10761111570005003901.b4-reply@b4>
	<aibYJvzQQnpoN6YW@plex>
Date: Tue, 09 Jun 2026 16:28:12 +0200
Message-ID: <2vxzo6hjss8z.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon, Jun 08 2026, Pasha Tatashin wrote:

> On 06-08 13:26, Mike Rapoport wrote:
>> On 2026-06-07 13:43:09+00:00, Pasha Tatashin wrote:
>> > On 06-07 14:58, Mike Rapoport wrote:
>> >=20
>> > > On Fri, 05 Jun 2026 03:32:26 +0000, Pasha Tatashin <pasha.tatashin@s=
oleen.com> wrote:
[...]
>> > External users only need to include the headers they actually use. For
>> > example, LUO shouldn't have to pull vmalloc or radix tree KHO
>> > declarations, and memfd does not need block.
>> >=20
>> > From a maintenance point of view, it is much easier to catch ABI
>> > changes when the file with the appropriate version has been changed,
>> > and most likely the version of that file should be updated. If a single
>> > header contains compatibility versions for several different data
>> > structures, it is easier to miss the correct version update.
>>=20
>> No matter in what files the definition lives, someone can forget to
>> update version and we may miss it during review.

Perhaps we should have some tests (maybe with kunit?) that can catch
this? If you change the format, the test fails. So you'd have to go and
update the test, and at that point it should be more obvious that ABI
version needs bumping.

[...]
>>=20
>> Sorry I wasn't clear. I agree that kho_vmalloc, block and radix tree
>> should have their own versioning rather than rely on global KHO version.
>>=20
>> What I don't like in your proposal is mixing versioning of a component
>> with its dependencies.
>>=20
>> I think that versioning should be completely local to each component.
>> LUO should not care about kho_block "on wire" layout. This should be
>> encapsulated in kho_block.
>
> That is a fair point.
>
> As I mentioned in my previous reply, we can definitely look into making=20
> the version checking more modular. For example, each component could=20
> implement a standard compatibility-checking interface.
>
> These checks could run early in boot to determine whether each component=
=20
> is capable of accepting the incoming preserved data format.
>
> Whenever the component is later used by LUO, memfd, etc., we can query=20
> that cached status. This achieves four key benefits:
>
> 1. It avoids delaying the compatibility check to the actual time of data=
=20
> retrieval, which is too late to safely abort.
>
> 2. It prevents a local incompatibility from triggering a global kernel=20
> panic, allowing us to handle failures gracefully for just that specific=20
> component or session.

I think the right time to do the compatibility check is _before_ kexec.
That is the only point where you can safely abort. Once you boot into
the new kernel and discover you can't understand the passed data, you
are in a bad spot already and should reboot. I don't think think you
really can gracefully handle these failures.

For example, say you fail to understand the incoming PCI data. So you
have no idea which devices are participating in live update and cannot
correctly probe any of them. Which effectively means you cannot resume
any of your guests since you have no idea how to restore their device
state. The only path you are left with is to reboot. I haven't read the
IOMMU series, but I imagine the same story applies there.

For a more benign example, let's assume one of your memfds that back VM
memory fail to restore.

In this case, you can safely leak that memory and run the other guests,
but at that point the host is in impaired state. You don't want to keep
running it in this state. You likely either do a reboot, or if you feel
more adventurous, you do another live update.

In either case, there is no "safely abort" after the kexec happens.

So I think our energy is better spent solving the versioning story
_before_ kexec. After kexec I think it is perfectly fine to error out
and panic or expect a reboot. You can't salvage much at that point
anyway.

And I think how the versioning format looks also should be based on the
design of this pre-kexec check, not the other way round.

>
> 3. It keeps the local version local, as you suggested, so it is checked=20
> only by the consumers of that specific component.
>
> 4. It provides a clean path for backward compatibility, as components=20
> can individually decide whether they understand the incoming data=20
> format.
>
[...]
>>=20
>> Actually FDT "compatible" handles versioning nicer than composite strings
>> You can have
>>=20
>> 	compatible=3D"kho-v4", "vmalloc-v1", "radix-v1", "block-v2";
>>=20
>> and check fdt_node_check_compatible("vmalloc-v1") for vmalloc and
>> fdt_node_check_compatible("block-v2") for block.

I agree. Even if we don't use FDT, something more structured than
composite strings would be nice to have.

>
> That is actually very similar to what I am proposing=E2=80=94individual v=
ersion=20
> tokens (which in my current series are concatenated into a composite=20
> compatibility string separated by ';').
>
> But let's not get too fixated on the composite string formatting. I=20
> actually really like what you are proposing: using integers for versions=
=20
> and having each registered component carry its own "NAME" and version=20
> number in the KHO FDT.

There is another nice thing about numbers that Logan (+cc) recently
pointed out. You can tell which one is bigger.

At some point I think we will support multiple versions of a data
structure to allow for upgrades. At that point, it will help to know
which one is "newer". So if both kernel versions support version 3 and
4, you can use 4 to serialize.

This of course is harder to do with strings.

>
>> And we wouldn't need to reimplement string parsing ;-)
>>=20
>> But yeah, I do see value of making components versioning and KHO global
>> versioning independent. I just don't like composite strings and I don't
>> like mixing versioning with dependencies.
>>=20
>> Since we are moving from FDT for the most things, version should become
>> a number rather than a string and version compatibility should be
[...]

--=20
Regards,
Pratyush Yadav

