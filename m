Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E401EC43334
	for <kexec@archiver.kernel.org>; Mon,  6 Jun 2022 08:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VKsdV0eMFQv6xcahajwUp5BgJ/VmaWsrWwop46sl1+A=; b=Qb9qFSTzTCyDzx
	/tdRT4/AuokavzhvrFtJdOH6ZIP2yce0Z1jNJHaiIvGKyHTmpD9ZO3OVJjyLwWyKsQwxTdRxiZ9Ma
	iRrmwfl/1GC7Jx9TskH03luLHf+G66nLVgVLZN60lhLIT+a+q4XhqxA33dwcDNC4gWsz+Mb3RJbGU
	fEa8cdliEkjoQ4sEGKyZq4AjWsw/qxEoXWiddfUIpwJFuzToNJcClRBExtT3IbsTY8ZV1Dx2pOivj
	UUjOIkvzzayoENPClOhBmrHj56wHJIOliE+WhsYw7nynHjcMFfkFMRd3ysGSyMfdjCFN8wA2k7Gan
	08cUsGK9KbQSZLdssKXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ny7xF-0005QS-2y; Mon, 06 Jun 2022 08:19:17 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ny7xC-0005Nj-0q
	for kexec@lists.infradead.org; Mon, 06 Jun 2022 08:19:15 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 255IPgP6002390;
	Mon, 6 Jun 2022 01:19:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=wr7x5AFxbYWsKZHVqOXL5XM7ksJ3ntrM3vSeFpptYGU=;
 b=KWyfwvInUSNSlcIYUP9GtbLqBpLZdYSBO9sAxKNHLUCxy90wx/dP22hkciLMLh+Ti2NN
 FAFgtV8rVXwgQAbmxVl+X9ZCSXFQliVFXScKi33isJd+qzmU7f8dHgmZv6hQigAlbRk+
 ZOzbH16GoVlY7n5gxmh4NO26J2maGSDV7X0= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gg6q3ehst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jun 2022 01:19:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gU9IkgJN+elMYs9P7PPzgHvId3dBQkbRFWP9HNUTv+wpQyeETHkjH/6mO4wR0kM8lU8xirAdnCfD4xBk+3T6QucC8ZX/wvf4ecgCSYfzmu5dzHeCLXLJhz9jitaL8ZEKTPkA8AoHH4qduyuVCumyPkLeq8QzGNAaDbeBIAKnJ/p6OLOJV2eJgJ8T7Ve0iqUMRynAzNstAbY6B5VpUsuJHkveS0YZCZgy1q32joOhfdaVEx0pyaRHYRw7eo92jVRgR8I8vNauIdyw0i7g8eQ2YemUWYNZb4hGCKAjd6n/znEAgUGXiLrAD9xuBX4PqHxM10NPVaixmgaTR8WAn8OvFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wr7x5AFxbYWsKZHVqOXL5XM7ksJ3ntrM3vSeFpptYGU=;
 b=OKOrss3pC0a0ZlkiFcfd+JrlVo3YP9tAz/+W4DNY40YIyijlhYY01396s+0uhKr8y1QlOludeIRhLQwvM/4dFQ+o2tGrfJlkk4xC0GZed6GseqHDRlN59pRBfnamqkV+XM40SJuNuHnCTKkSSBPeWKkKz1UaZkF4ooebwqm/6Il7xjx4PkIGLxST5qPHGWGhDlyToeJvS/rI3zjnni6fO3WCvmEyCDkJfK/zLTf7R5hbcqQgukyTHXjc+p1YihPoeTauIVvUauzo4KXAEhQmxqo+DwOKKyp4AwTMPY4dAw95YNv7Pp/UjwdBfcQqOtmDl05j3SXdNRNgbNvEtcWvGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by SA1PR15MB4723.namprd15.prod.outlook.com (2603:10b6:806:19e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Mon, 6 Jun
 2022 08:19:05 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::1dd0:f1c9:43d7:b7ab]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::1dd0:f1c9:43d7:b7ab%9]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 08:19:05 +0000
From: Jonathan McDowell <noodles@fb.com>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>
CC: Mimi Zohar <zohar@linux.ibm.com>,
        "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>,
        Alasdair G Kergon <agk@redhat.com>,
        Lakshmi
 Ramasubramanian <nramas@linux.microsoft.com>,
        Tyler Hicks
	<tyhicks@linux.microsoft.com>
Subject: Re: need help: patches to capture events between kexec load and
 execute
Thread-Topic: need help: patches to capture events between kexec load and
 execute
Thread-Index: AQHYd9qW1GgCrEBk6kShX73VAAMTWa1CDHKA
Date: Mon, 6 Jun 2022 08:19:05 +0000
Message-ID: <Yp24dc/i8XU9A+5/@noodles-fedora.dhcp.thefacebook.com>
References: <c33ba2f1-bacd-54dd-90d7-b0ab82568fff@linux.microsoft.com>
In-Reply-To: <c33ba2f1-bacd-54dd-90d7-b0ab82568fff@linux.microsoft.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d793099-77af-4af5-c42f-08da479538b9
x-ms-traffictypediagnostic: SA1PR15MB4723:EE_
x-microsoft-antispam-prvs:  <SA1PR15MB472358DB30CA15D687BC764FC1A29@SA1PR15MB4723.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  Vn36kQHPtV9K0zdqx1KtquFANH0IC/I/BjLOeUW2fKAgY009OJt7h0P9SVksF2Non/2t96jN48oUpddxBZpPHkuohSueWBzkfQKNarVmVspu4ea/wSP5cnqGiAczXgIHN4syVlrHhhjT3cMrsVuFjbn2Hq7zS/zRsb/q48XrgzDKrBKxIalxy7lsb5IgrCABfyhPFztPinzZSy6A6MseM6rU+ZYFXZOJBSezi1Ih3eN6JQF7tYL9NoAwNJrEQcwMAk8Cpzks66bF/EwCg0rCz9IBXl84Kstvjn1SYc6FWCi6Rg+UBmTfyXxV2qvWJ5Zs/85/l20ZJMV3I0UXYFOPd8J5/lTtE2yYX2r4v4wjomxw0pPxaBKJA6VI0C7NE+RLaG/0nFDC/mQ+LgE5XwGibD/EpOx7BwY+UTK2xb/bUMPm7BnD988ngOWjAtcRFZAlR/Z5a77orwZJAuSNcm146t1LDnTaBhfnkxjKvlh/dVuJQwK2yVxuzQgB/s5R7efZdGbrACz7jKtU58qmodRjWIfQiEpCPpTLM9hum6wUU4kVM6PCkNz8PmHjZPhyKL0xLUBcdFAJxfBb1OPRygULqp1++3ZGwo5hYkWcVgN+n1a2f31Va2mxtYTQlahcxT9Q0r8UfjsOrksJI23xqLMMbLA50o6K/jQkx63eu2jzgPlvpkGCVfRNlu43OK57C6iWWFJSDFgyME2GotUydIroPw==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(26005)(38070700005)(71200400001)(8936002)(9686003)(122000001)(6512007)(508600001)(6506007)(5660300002)(38100700002)(6486002)(316002)(83380400001)(8676002)(6916009)(54906003)(64756008)(66476007)(91956017)(76116006)(66946007)(66556008)(66446008)(4326008)(186003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?8LV1SAE8NdTp1tioRF62ewy3Vvmm5obLBwNc1ZmfaeHMlkVkSlmF5N89fCI1?=
 =?us-ascii?Q?p55ltaD3pYoBYDg0S9oZoDn0xIRElhsWVVfCG20c6UCvJgeIPpdciaqFPF1O?=
 =?us-ascii?Q?NXEATpM/qVX2q/2KBMa+Y3xgSPLK9zJgU3a/p9XTH6Tli6QJXbzmrz88C8y5?=
 =?us-ascii?Q?I0HMNyp2cOXY/nBl9H3XJQ/rPLVNbEcL2XY22nMZ/o8iMFTsv+R0ilso3dyK?=
 =?us-ascii?Q?mZIzycGg+jpOnEoiXONLcUp9+VEHLNTLk3erz93m4KBCTeT1A0TyHYDz2c9s?=
 =?us-ascii?Q?LiCuqLVip1whNEZcQd6YBkE1qXYDbjWAweHZxdMRtduC75iES3Mm64wLI60H?=
 =?us-ascii?Q?m61a4vK9OoKBZhcLQwUo0eXIgCLXCfEvmpBXcVdApJ3LfY4w0mmeKOO2c3OB?=
 =?us-ascii?Q?V2M4+I3sOQgyjsSnN5CXZSgIT20CpNQOafvmlGN8X+iOoyJIZ/zZvisRmize?=
 =?us-ascii?Q?ItvMHt/K0m3aB0YqUXQyqFq5L6CCO7UE4naMQk9lQMql22dF+Tj8hCbC+T6Z?=
 =?us-ascii?Q?SfUEyZ1pzfVeUJ9p1aakgGZ2RJlko45C2Q8d6o/Ps6gPsdlCelpgjm94DdnP?=
 =?us-ascii?Q?UqsUHL94qeAM5hXZkvZRF5Ga8ytxD7W7GlIHGMwLOs1xq3x176vwdIFffCgW?=
 =?us-ascii?Q?QOOkNbVGZ8wcnjd++bWsjWD38TG+xqOwOThHRhsfbeg+NXYhDh/KzGFXg1dY?=
 =?us-ascii?Q?IaMV7BAjJ9kAWXl4aaX5kjg9EisbzVbRmhj/9u86tnq7B9E3PyPHEGi/dnav?=
 =?us-ascii?Q?vFwsOQDiTGrEPjpv6fJt4VZJqaR/PLzF13ghEujAKQhl7GiUrkbnQjT5NsvE?=
 =?us-ascii?Q?1gHH1UYOv5EuEQRtkyQ4gMEWSVMDwnt/RfOMXD2yNZ4iWUDUZkP0D/NFAZMy?=
 =?us-ascii?Q?axPO0hgRbkFc5XjCozajpl1rSuhKjLIwIXydiGKc4TZn+aVH7l8wKPj+4MNO?=
 =?us-ascii?Q?UREvuExyeo9Pc/2GFYEMa9k0wRq6u6loqlMALs3S5dqmDPjTLaT8wH3n/2Wk?=
 =?us-ascii?Q?lF/TQyVFa87uxW3cwN1EB/RCmdB+8aVTSPFb5mStvVkp/uQhshZbCDAyA+RG?=
 =?us-ascii?Q?r+RoesA23cYDi4ZCCI4nVWpLUqVxMhEnFN/k+PY8RSouFUZ4UDHee33VlKIv?=
 =?us-ascii?Q?FhhehvQuEQDPAVD3yj4Rn2r8iXHkZa+RIQpe7QSBnQzo8q8HkNbdwcCwwG8O?=
 =?us-ascii?Q?CI1BZe2bWYF6L6q3HSqnQ9JIUuWbIUZNIr4Ks1JmX13grEHEf1UnphVYjJ9h?=
 =?us-ascii?Q?tyUDCfbHFwSAzgYNTPk2RwFB5uY6RwppS3ie+6UCur3Ifh6eVGAeQYASCRza?=
 =?us-ascii?Q?ACBmiIC51rqOQFd8wb2himm6J/Qa5ZbASzuCs30ec35Tf+8ETfiZhEjTwdG5?=
 =?us-ascii?Q?6FgJuQAP8gYYmYvu+u51wJ1NKJle1kbiH6VZHWBmPgoVvaxDHv1+EsuTaoYD?=
 =?us-ascii?Q?L6xAgXDsb+CNueXN4R6Co9WjllDcxeAHGdivqEYwqI0ll8JpLlq308aeczsa?=
 =?us-ascii?Q?WP5taJbhVBO6Ja/H+5BaXvLBgPTtwWy4fS5kc2xCh+tZ2KSppihkmbPVGP+I?=
 =?us-ascii?Q?yKUaVE7W+Wk3jC8+J2YNH4qUHrL6ChXCVB0bBWur5/FS/A6Rh+5Ak/0SZXr3?=
 =?us-ascii?Q?DIjx8npRix99OYgUuCYiFtIq5ZEO0WscQIOQERsNdePsSnfCYc1jdvoiTG4F?=
 =?us-ascii?Q?/7F11TSnlyaJK8fSQDDAQBadA/YvjOl2Ugu8appPTRwrS+zcgIkQRFtgK1/B?=
 =?us-ascii?Q?0YZLn+Zlzg=3D=3D?=
Content-ID: <CCD279E4EBC3CA4BA4D49CB0FA05FC9C@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d793099-77af-4af5-c42f-08da479538b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2022 08:19:05.3431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QJ+w70mliiAzNeiV15O2kPvfnxbpn/+GnLijR65J9n8WrNjA+Uqu9me77/KtqCCy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4723
X-Proofpoint-ORIG-GUID: Ca8yALFoKHoeyXYA_MfJ6fmTrJVM77IK
X-Proofpoint-GUID: Ca8yALFoKHoeyXYA_MfJ6fmTrJVM77IK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-06_02,2022-06-03_01,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220606_011914_145539_17405057 
X-CRM114-Status: GOOD (  40.43  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Fri, Jun 03, 2022 at 11:16:04PM -0700, Tushar Sugandhi wrote:
> We believe we have found one gap in the IMA/kexec interaction.
> And we need your inputs as Linux Kernel maintainers/experts to fix that
> gap.
> 
> -------------
> Problem:
> -------------
> The current Kernel behavior is IMA measurements are snapshotted at
> 'kexec load' and not at 'kexec execute'.  And IMA log is then carried
> over to the new Kernel after 'kexec execute'.
> 
> Some systems can be configured to call 'kexec load' first, and followed
> by 'kexec execute' after some time.  (as opposed to calling 'load' and
> 'execute' in one single kexec command).  In this scenario, if new IMA
> measurements are added between 'kexec load' and 'kexec execute' - the
> TPM PCRs are extended with the IMA events between load and execute, but
> those IMA events are not carried over to the new kernel after kexec soft
> reboot.  This results in mismatch between TPM PCR quotes and the actual
> IMA measurements log post kexec.
> 
> ===========================================================================
> -------------
> Scenario
> -------------
> Here is the order of operations I followed to confirm the issue.
> 
> (a) Call 'kexec load'
> 
>     #kexec -s -l /etc/ima/Image.kexec --reuse-cmdline
> 
> 
> (b) Touch one of the files that would be measured by IMA
> 
>     #cat /run/systemd/journal/streams/8:16351
> 
> 
> (c) Verify that this measurement event is part of the IMA log.
> 
>     #cat /sys/kernel/security/ima/ascii_runtime_measurements | grep 16351
> 
>     <returns the file entry in IMA log>
> 
> (d) Call 'kexec execute'
> 
>     #kexec -s -e
> 
> 
> (e) After kexec soft reboot, the file measurement event is not present
>     in the IMA log anymore.  Because this measurement in the previous
>     kernel had happened after the IMA log was snapshotted in the
>     previous kernel.
> 
>     #cat /sys/kernel/security/ima/ascii_runtime_measurements | grep 16351
> 
>     <does not return the file entry in IMA log>
> 
> ===========================================================================
> -------------
> Solution
> -------------
> Tyler pointed me to the past work in this area.
> (Please see references section below)
> 
> I used it to create the patches for capturing IMA events in between
> "kexec load" and "kexec execute". (please find attached)
> 
> - 0001-kexec_file-Add-mechanism-to-update-kexec-segments.patch
> - 0002-ima-update-kexec-buffer-before-executing-soft-reboot.patch
> - 0003-ima-on-soft-reboot-save-the-measurement-list.patch
> 
> My patches are based on [1] and [2] in the References section below.
> I also looked at [3].  It has a few kexec_*_handover_buffer().
> I was not sure if they were needed.  As per my limited understanding in
> kexec space [1] and [2] together seemed sufficient for the solution.
> ===========================================================================
> ------------------------------------------
> Problems in the solution above
> ------------------------------------------
> Earlier my solution patches were crashing the Kernel. After a few fixes,
> the patches are not crashing the Kernel anymore, but they don't seem to be
> working to capture the events between 'kexec load' and 'kexec execute'
> either.
> 
> When I was debugging it using printks and gdb, I found one potential
> location where it was failing.
> 
> test_0001-move-ima_add_kexec_buffer-from-kexec-load-to-execute.patch
> has that location.
> 
> 
> I would really appreciate if someone of you could help me provide
> further guidance to make progress on this work.

The main piece that seems to be missing is updating the size of the IMA
buffer in the mechanism used to pass its details to the new kernel (so
device tree in current mainline [setup_ima_buffer], the setup_data piece
in my x86_64 patches). Without that you'll only load the original set of
measurements even if the extra data is in the buffer.

I think there's also a potential problem in that you assume an extra
page is sufficient for any additional measurements which may or may not
be the case - I don't see any check in ima_update_kexec_buffer that the
buffer is big enough for the new IMA data.

J.
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
