Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABBAC55822
	for <kexec@archiver.kernel.org>; Tue,  4 Aug 2026 22:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tKXkCcRMGWTSPIx2M+vUMflHbZbJ8UbKojm3V5koHzo=; b=jq19nH2KSmXnuVKyKloiCNV7bu
	ISi95yEGVGQz5xtLEocoAP+fhh/s2i68E8Yo1uZCG/HFknpOO+bK1XokiCN++EDsVVjuv+u00XVr8
	rX11VFw19r0vGv+h2r1pPRxjMtpWOYPzqQfuu8X9unfLg+ajPry+vI4uphPXFJxGrGV6MQpP2jDx1
	0tx3P5Lyf83BbKBH6V3sVukKGI1p3K5LxXzeFiTXbSj13JGqtEDEOZ8sFnXc/CtM2MEA951c56IbT
	twLYrCUfViQTZWctYDHAeJOznUJk/oBpNKJeapu9Pmg7KGbDLkK0urmdNOD4/XEjE8p5gMyzfwCxd
	q0hJwOew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrNUg-00000002rbS-1qNk;
	Tue, 04 Aug 2026 22:20:18 +0000
Received: from out-187.mta1.migadu.com ([95.215.58.187])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrNUc-00000002rb0-1PZd
	for kexec@lists.infradead.org;
	Tue, 04 Aug 2026 22:20:17 +0000
Message-ID: <0556e2fc-3be5-4023-a9a4-8482fa8c88b2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785882008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tKXkCcRMGWTSPIx2M+vUMflHbZbJ8UbKojm3V5koHzo=;
	b=lTXbSSZvUL4SJfXOdF++4CEyApWmTqxUjaeN3mxQ5u2ImrIEJbHG0FEnJvV/uRJtJqfwL8
	mwnnvc7kyeVO+Fc7xM4qFj50XL1gBgWop+y6QXPTKGtqB13iyT9UTjAt1jKvF/BsIuPuEI
	u0ci3Zm3/p+4lDVk2TCJM5RXUmBPSGQ=
Date: Tue, 4 Aug 2026 15:19:34 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v5 17/20] vfio: selftests: Add
 vfio_pci_liveupdate_kexec_test
To: Vipin Sharma <vipinsh@google.com>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com,
 ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com,
 chrisl@kernel.org, christian.koenig@amd.com, corbet@lwn.net,
 dmatlack@google.com, graf@amazon.com, jacob.pan@linux.microsoft.com,
 jgg@nvidia.com, jgg@ziepe.ca, jrhilke@google.com, julianr@linux.ibm.com,
 kees@kernel.org, kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com,
 lukas@wunner.de, mattev@meta.com, michal.winiarski@intel.com,
 parav@nvidia.com, pasha.tatashin@soleen.com, praan@google.com,
 pratyush@kernel.org, rananta@google.com, rientjes@google.com,
 rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com,
 schnelle@linux.ibm.com, skhan@linuxfoundation.org, skhawaja@google.com,
 vivek.kasireddy@intel.com, witu@nvidia.com, yi.l.liu@intel.com
References: <20260714151505.3466855-1-vipinsh@google.com>
 <20260714151505.3466855-18-vipinsh@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20260714151505.3466855-18-vipinsh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260804_152014_527297_47BB7630 
X-CRM114-Status: GOOD (  30.66  )
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


On 7/14/26 8:15 AM, Vipin Sharma wrote:
> Add a selftest to exercise preserving a vfio-pci device across a Live
> Update. For now the test is extremely simple and just verifies that the
> device file can be preserved and retrieved. In the future this test will
> be extended to verify more parts about device preservation as they are
> implemented.
>
> This test is added to TEST_GEN_PROGS_EXTENDED since it must be run
> manually along with a kexec.
>
> To run this test manually:
>
>   $ tools/testing/selftests/vfio/scripts/setup.sh 0000:00:04.0
>   $ tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test --stage 1 0000:00:04.0
>
>   $ kexec ...   # NOTE: Exact method will be distro-dependent
>
>   $ tools/testing/selftests/vfio/scripts/setup.sh 0000:00:04.0
>   $ tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test --stage 2 0000:00:04.0
Hi, Vipin

Thanks a lot for your help. I followed your suggestion, vfio-pci setup can
work.

The followings are the test result. In the step 3, after kexec, there are
some fails. I am not sure if these are known problem or not.

1. Before kexec command

+ modprobe -v vfio-pci
+ tools/testing/selftests/vfio/scripts/setup.sh 0000:00:04.0
+ echo "vfio-pci" > /sys/bus/pci/devices/0000:00:04.0/driver_override
+ echo "0000:00:04.0" > /sys/bus/pci/drivers/vfio-pci/bind
+ tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test --stage 1
0000:00:04.0
Preserving device in session
Preserving memfd of size 0x40100000 in session
# [STAGE 1] Forking persistent child to hold sessions...
# [STAGE 1] Child PID: 1236. Resources are pinned.
# [STAGE 1] You may now perform kexec reboot.
+ set +x

2. Run kexec command

3. After kexec command

+ echo "vfio-pci" > /sys/bus/pci/devices/0000:00:04.0/driver_override
+ echo "0000:00:04.0" > /sys/bus/pci/drivers/vfio-pci/bind
Checking open(/dev/vfio/devices/vfio0) fails  <--- I can confirm that the
/dev/vfio/devices/vfio0 exists. But open this failed.
Checking ioctl(group_fd, VFIO_GROUP_GET_DEVICE_FD, "0000:00:04.0") fails
(vfio_type1_iommu)      <--- fails
Checking ioctl(group_fd, VFIO_GROUP_GET_DEVICE_FD, "0000:00:04.0") fails
(vfio_type1v2_iommu).  <--- fails
Checking ioctl(group_fd, VFIO_GROUP_GET_DEVICE_FD, "0000:00:04.0") fails
(iommufd_compat_type1)  <--- fails
Checking ioctl(group_fd, VFIO_GROUP_GET_DEVICE_FD, "0000:00:04.0") fails
(iommufd_compat_type1v2). <--- fails
Retrieving memfd from LUO
Finishing the session before retrieving the device (should fail)
Retrieving the device FD from LUO
Finishing the session before binding to iommufd (should fail)
Binding the device to an iommufd and setting it up
Finishing the session

# lspci -vvv -s 0000:00:04.0
00:04.0 Unclassified device [00ff]: Red Hat, Inc. QEMU PCI Test Device
     Subsystem: Red Hat, Inc. QEMU Virtual Machine
     Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- INTx-
     IOMMU group: 16
     Region 0: Memory at fea23000 (32-bit, non-prefetchable) [size=4K]
     Region 1: I/O ports at c000 [size=256]
     Kernel driver in use: vfio-pci

Zhu Yanjun

>
> The second call to setup.sh is necessary because preserved devices are
> not bound to a driver after Live Update. Such devices must be manually
> bound by userspace after Live Update via driver_override.
>
> This test is considered passing if all commands exit with 0.
>
> Co-developed-by: David Matlack <dmatlack@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>
> Signed-off-by: Vipin Sharma <vipinsh@google.com>
> ---
>   tools/testing/selftests/vfio/Makefile         |  4 +
>   .../vfio/vfio_pci_liveupdate_kexec_test.c     | 89 +++++++++++++++++++
>   2 files changed, 93 insertions(+)
>   create mode 100644 tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
>
> diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
> index 591f1a52c310..a2f0a459e1f4 100644
> --- a/tools/testing/selftests/vfio/Makefile
> +++ b/tools/testing/selftests/vfio/Makefile
> @@ -15,6 +15,10 @@ TEST_GEN_PROGS += vfio_pci_driver_test
>   TEST_GEN_PROGS += vfio_pci_sriov_uapi_test
>   TEST_GEN_PROGS += vfio_pci_liveupdate_uapi_test
>   
> +# This test must be run manually since it requires the user/automation to
> +# perform a kexec during the test.
> +TEST_GEN_PROGS_EXTENDED += vfio_pci_liveupdate_kexec_test
> +
>   TEST_FILES += scripts/cleanup.sh
>   TEST_FILES += scripts/lib.sh
>   TEST_FILES += scripts/run.sh
> diff --git a/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c b/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
> new file mode 100644
> index 000000000000..15b3e3af91d1
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c
> @@ -0,0 +1,89 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <libliveupdate.h>
> +#include <libvfio.h>
> +
> +static const char *device_bdf;
> +
> +static char state_session[LIVEUPDATE_SESSION_NAME_LENGTH];
> +static char device_session[LIVEUPDATE_SESSION_NAME_LENGTH];
> +
> +enum {
> +	STATE_TOKEN,
> +	DEVICE_TOKEN,
> +};
> +
> +static void before_kexec(int luo_fd)
> +{
> +	struct vfio_pci_device *device;
> +	struct iommu *iommu;
> +	int session_fd;
> +	int ret;
> +
> +	iommu = iommu_init("iommufd");
> +	device = vfio_pci_device_init(device_bdf, iommu);
> +
> +	create_state_file(luo_fd, state_session, STATE_TOKEN, /*next_stage=*/2);
> +
> +	session_fd = luo_create_session(luo_fd, device_session);
> +	VFIO_ASSERT_GE(session_fd, 0);
> +
> +	printf("Preserving device in session\n");
> +	ret = luo_session_preserve_fd(session_fd, device->fd, DEVICE_TOKEN);
> +	VFIO_ASSERT_EQ(ret, 0);
> +
> +	close(luo_fd);
> +	daemonize_and_wait();
> +}
> +
> +static void after_kexec(int luo_fd, int state_session_fd)
> +{
> +	struct vfio_pci_device *device;
> +	struct iommu *iommu;
> +	int session_fd;
> +	int device_fd;
> +	int stage;
> +
> +	restore_and_read_stage(state_session_fd, STATE_TOKEN, &stage);
> +	VFIO_ASSERT_EQ(stage, 2);
> +
> +	session_fd = luo_retrieve_session(luo_fd, device_session);
> +	VFIO_ASSERT_GE(session_fd, 0);
> +
> +	printf("Finishing the session before retrieving the device (should fail)\n");
> +	VFIO_ASSERT_NE(luo_session_finish(session_fd), 0);
> +
> +	printf("Retrieving the device FD from LUO\n");
> +	device_fd = luo_session_retrieve_fd(session_fd, DEVICE_TOKEN);
> +	VFIO_ASSERT_GE(device_fd, 0);
> +
> +	printf("Finishing the session before binding to iommufd (should fail)\n");
> +	VFIO_ASSERT_NE(luo_session_finish(session_fd), 0);
> +
> +	printf("Binding the device to an iommufd and setting it up\n");
> +	iommu = iommu_init("iommufd");
> +
> +	/*
> +	 * This will invoke various ioctls on device_fd such as
> +	 * VFIO_DEVICE_GET_INFO. So this is a decent sanity test
> +	 * that LUO actually handed us back a valid VFIO device
> +	 * file and not something else.
> +	 */
> +	device = __vfio_pci_device_init(device_bdf, iommu, device_fd);
> +
> +	printf("Finishing the session\n");
> +	VFIO_ASSERT_EQ(luo_session_finish(session_fd), 0);
> +
> +	vfio_pci_device_cleanup(device);
> +	iommu_cleanup(iommu);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	device_bdf = vfio_selftests_get_bdf(&argc, argv);
> +
> +	sprintf(device_session, "device-%s", device_bdf);
> +	sprintf(state_session, "state-%s", device_bdf);
> +
> +	return luo_test(argc, argv, state_session, before_kexec, after_kexec);
> +}

